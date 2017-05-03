module Update exposing (..)

import Msgs exposing (Msg)
import Sidebar.Msgs as Sidebar exposing (SidebarMsg)
import BottomBar.Msgs as Player exposing (PlayerMsg)
import Explore.Msgs as Explore exposing (ExploreMsg)
import Search.Msgs as Search exposing (SearchMsg)

import Models exposing (Model)
import Commands exposing (fetchArtist, fetchTopTracks, fetchRelatedArtists, fetchArtistById)
import Ports exposing (playAudio, pauseAudio, provideTracks, nextTrack, previousTrack, updateCurrentTime, updateVolume, initVis, destroyVis, addSimilar)
import RemoteData
import Routing exposing (parseLocation)
import Constants exposing (maxRelatedArtists)

import Helpers
import ModelHelpers

updatePlayer : PlayerMsg -> Model -> (Model, Cmd Msg)
updatePlayer msg model =
  case msg of
    Player.Play previewUrl ->
      ({ model | isPlaying = True }, Cmd.map Msgs.MsgForPlayer (playAudio previewUrl))

    Player.Pause ->
      ({ model | isPlaying = False }, Cmd.map Msgs.MsgForPlayer (pauseAudio ""))

    Player.Stop value ->
      ({ model | isPlaying = False}, Cmd.none)

    Player.Next ->
      (model, Cmd.map Msgs.MsgForPlayer (nextTrack ""))

    Player.Previous ->
      (model, Cmd.map Msgs.MsgForPlayer (previousTrack ""))

    Player.UpdateAudioStatus audioStatus ->
      ({ model | audioStatus = audioStatus}, Cmd.none)

    Player.UpdateCurrentTime time ->
      let
        currentTime =
          Helpers.pctToValue
            (Result.withDefault model.audioStatus.currentTime (String.toFloat time))
            model.audioStatus.duration
      in
        ({ model
        | audioStatus = ModelHelpers.setAudioStatusTime currentTime model.audioStatus }
        , Cmd.map Msgs.MsgForPlayer (updateCurrentTime currentTime))

    Player.UpdateVolume volume ->
      let
        newVolume = (Result.withDefault model.audioStatus.volume (String.toFloat volume)) / 100
      in
        ({ model
        | audioStatus = ModelHelpers.setAudioStatusVolume newVolume model.audioStatus }
        , Cmd.map Msgs.MsgForPlayer (updateVolume newVolume))

updateSidebar : SidebarMsg -> Model -> (Model, Cmd Msg)
updateSidebar msg model =
  case msg of
    Sidebar.ToggleSidebar ->
      ({ model | showMenu = not model.showMenu }, Cmd.none)

    Sidebar.SelectTrack track ->
      ({ model | selectedTrack = Maybe.Just track, isPlaying = True }, playAudio track.preview_url)

    Sidebar.TopTracksSuccess response ->
      case response of
        RemoteData.Success tracks ->
          if model.waitingToPlay then
            case List.head tracks.tracks of
              Just track ->
                let
                  newModel =
                    { model
                    | topTracks = response
                    , selectedTrack = Just track
                    , waitingToPlay = False
                    }
                in
                  (newModel, Cmd.batch [provideTracks tracks, playAudio track.preview_url])

              Nothing ->
                ({ model | topTracks = response, waitingToPlay = False }, provideTracks tracks)
          else
            ({ model | topTracks = response}, provideTracks tracks)

        _ ->
          ({ model | topTracks = response}, Cmd.none)

updateExplore : ExploreMsg -> Model -> (Model, Cmd Msg)
updateExplore msg model =
  case msg of
    Explore.OnVisNodeClick artistId ->
      ({ model | topTracks = RemoteData.Loading }, Cmd.map Msgs.MsgForExplore (fetchArtistById artistId))

    Explore.ArtistByIdSuccess response ->
      case response of
        RemoteData.Success artist ->
          let
            commands = Cmd.batch
              [ Cmd.map Msgs.MsgForExplore (fetchRelatedArtists artist.id)
              , Cmd.map Msgs.MsgForSidebar (fetchTopTracks artist.id)
              ]

            newModel =
              if (List.length <| Helpers.filterArtistsWithRelated artist.id model.playlistArtists) > 0 then
                ({ model
                | selectedArtist = Just artist
                }
                , Cmd.map Msgs.MsgForSidebar (fetchTopTracks artist.id)
                )
              else
                let
                  newArtist = { artist | hasRelated = True }
                in
                  ({ model
                  | selectedArtist = Just newArtist
                  , playlistArtists = newArtist :: model.playlistArtists
                  }
                  , commands
                  )
          in
            newModel

        _ ->
          (model, Cmd.none)

    Explore.UpdateNetwork data ->
      let
        previousNetwork = model.network

        newNetwork =
          { previousNetwork | nodes = previousNetwork.nodes, edges = previousNetwork.edges }
      in
        ({ model | network = newNetwork }, Cmd.none)

    Explore.OnDoubleClick artistId ->
      ({ model | waitingToPlay = True }, Cmd.none)

    Explore.RelatedArtistsSuccess response ->
      case response of
        RemoteData.Success data ->
          let
            newArtists =
                Helpers.filterNewArtists data.artists model.network.nodes
                |> List.take maxRelatedArtists

            nodes =
              List.map Helpers.artistToNode newArtists

            edges =
              case model.selectedArtist of
                Just artist ->
                  Helpers.filterNewArtists data.artists model.network.nodes
                  |> List.take maxRelatedArtists
                  |> Helpers.artistsToEdge artist.id

                Nothing ->
                  []

            newNodes =
              List.append model.network.nodes nodes

            newEdges =
              List.append model.network.edges edges

            previousNetwork = model.network

            newNetwork =
              { previousNetwork | nodes = newNodes, edges = newEdges }

            newPlaylistArtists =
              List.append model.playlistArtists newArtists

            newModel =
              { model
              | relatedArtists = response
              , network = newNetwork
              , playlistArtists = newPlaylistArtists
              }
          in
            (newModel, addSimilar (nodes, edges))

        _ ->
          ({ model | relatedArtists = response }, Cmd.none)

updateSearch : SearchMsg -> Model -> (Model, Cmd Msg)
updateSearch msg model =
  case msg of
    Search.Search term ->
      let
        cmd =
          if String.length term > 1 then
            Cmd.map Msgs.MsgForSearch (fetchArtist term)
          else
            Cmd.none
      in
        ({ model | searchTerm = term } , cmd)

    Search.SearchArtistSuccess response ->
      ({ model | artists = response }, Cmd.none)

    Search.StartSearch ->
      ({ model | searching = True }, Cmd.none)

    Search.SelectArtist artist ->
      let
        newModel =
          { model
          | selectedArtist = Maybe.Just artist
          , route = Models.ExploreRoute
          }
      in
        (newModel, Cmd.map Msgs.MsgForSidebar (fetchTopTracks artist.id))

update : Msg -> Model -> (Model, Cmd Msg)
update msgFor model =
  case msgFor of
    Msgs.MsgForPlayer msgFor ->
      updatePlayer msgFor model

    Msgs.MsgForSidebar msgFor ->
      updateSidebar msgFor model

    Msgs.MsgForExplore msgFor ->
      updateExplore msgFor model

    Msgs.MsgForSearch msgFor ->
      updateSearch msgFor model

    Msgs.OnLocationChange location ->
      let
        newRoute = parseLocation location
      in
        case newRoute of
          Models.ExploreRoute ->
            let
              previousNetwork = model.network
              firstNetworkNode =
                List.head previousNetwork.nodes

              selectedArtistNode =
                case model.selectedArtist of
                  Just artist ->
                    Helpers.artistToNode artist

                  Nothing ->
                    Models.VisNode "" "" 0 "" ""

              newData =
                case firstNetworkNode of
                  Just node ->
                    if selectedArtistNode.id == node.id then
                      (model, previousNetwork)
                    else
                      ({ model | playlistArtists = [] }, { previousNetwork | nodes = [ selectedArtistNode ], edges = []})

                  Nothing ->
                    ({ model | playlistArtists = [] }, { previousNetwork | nodes = [ selectedArtistNode ], edges = []})

              newModel = Tuple.first newData
              newNetwork = Tuple.second newData
            in
              ({ newModel | route = newRoute, network = newNetwork }, Cmd.map Msgs.MsgForExplore (initVis newNetwork))

          _ ->
            ({ model | route = newRoute }, Cmd.map Msgs.MsgForExplore (destroyVis ""))
