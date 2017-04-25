module Update exposing (..)

import Msgs exposing (Msg)
import Models exposing (Model)
import Commands exposing (fetchArtist, fetchTopTracks, fetchRelatedArtists, fetchArtistById)
import Ports exposing (playAudio, pauseAudio, provideTracks, nextTrack, previousTrack, updateCurrentTime, updateVolume, initVis, destroyVis, addSimilar)
import RemoteData
import Routing exposing (parseLocation)
import Constants exposing (maxRelatedArtists)

import Helpers
import ModelHelpers

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Msgs.Search term ->
      let
        cmd =
          if String.length term > 1 then
            fetchArtist term
          else
            Cmd.none
      in
        ({ model | searchTerm = term } , cmd)

    Msgs.Play previewUrl ->
      ({ model | isPlaying = True}, playAudio previewUrl)

    Msgs.Pause ->
      ({ model | isPlaying = False }, pauseAudio "")

    Msgs.Stop value ->
      ({ model | isPlaying = False}, Cmd.none)

    Msgs.Next ->
      (model, nextTrack "")

    Msgs.Previous ->
      (model, previousTrack "")

    Msgs.ToggleSidebar ->
      ({ model | showMenu = not model.showMenu }, Cmd.none)

    Msgs.SearchArtistSuccess response ->
      ({ model | artists = response }, Cmd.none)

    Msgs.StartSearch ->
      ({ model | searching = True }, Cmd.none)

    Msgs.TopTracksSuccess response ->
      case response of
        RemoteData.Success tracks ->
          ({ model | topTracks = response}, provideTracks tracks)

        _ ->
          ({ model | topTracks = response}, Cmd.none)

    Msgs.RelatedArtistsSuccess response ->
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

    Msgs.SelectArtist artist ->
      let
        newModel =
          { model
          | selectedArtist = Maybe.Just artist
          , route = Models.ExploreRoute
          }
      in
        (newModel, fetchTopTracks artist.id)

    Msgs.SelectTrack track ->
      ({ model | selectedTrack = Maybe.Just track, isPlaying = True }, playAudio track.preview_url)

    Msgs.UpdateAudioStatus audioStatus ->
      ({ model | audioStatus = audioStatus}, Cmd.none)

    Msgs.UpdateCurrentTime time ->
      let
        currentTime =
          Helpers.pctToValue
            (Result.withDefault model.audioStatus.currentTime (String.toFloat time))
            model.audioStatus.duration
      in
        ({ model
        | audioStatus = ModelHelpers.setAudioStatusTime currentTime model.audioStatus }
        , updateCurrentTime currentTime)

    Msgs.UpdateVolume volume ->
      let
        newVolume = (Result.withDefault model.audioStatus.volume (String.toFloat volume)) / 100
      in
        ({ model
        | audioStatus = ModelHelpers.setAudioStatusVolume newVolume model.audioStatus }
        , updateVolume newVolume)

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

              newNetwork =
                case firstNetworkNode of
                  Just node ->
                    if selectedArtistNode.id == node.id then
                      previousNetwork
                    else
                      { previousNetwork | nodes = [ selectedArtistNode ]}

                  Nothing ->
                    { previousNetwork | nodes = [ selectedArtistNode ]}
            in
              ({ model | route = newRoute, network = newNetwork }, initVis newNetwork)

          _ ->
            ({ model | route = newRoute }, destroyVis "")

    Msgs.OnVisNodeClick artistId ->
      (model, fetchArtistById artistId)

    Msgs.ArtistByIdSuccess response ->
      case response of
        RemoteData.Success artist ->
          ({ model | selectedArtist = Just artist }, Cmd.batch[fetchRelatedArtists artist.id, fetchTopTracks artist.id])

        _ ->
          (model, Cmd.none)

    Msgs.UpdateNetwork data ->
      let
        previousNetwork = model.network

        newNetwork =
          { previousNetwork | nodes = previousNetwork.nodes, edges = previousNetwork.edges }
      in
        ({ model | network = newNetwork }, Cmd.none)
