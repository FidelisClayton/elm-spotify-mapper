module Update exposing (..)

import Msgs exposing (Msg)
import Sidebar.Msgs as Sidebar exposing (SidebarMsg)
import BottomBar.Msgs as Player exposing (PlayerMsg)
import Explore.Msgs as Explore exposing (ExploreMsg)
import Search.Msgs as Search exposing (SearchMsg)

import BottomBar.Update exposing (updatePlayer)
import Explore.Update exposing (updateExplore)
import Sidebar.Update exposing (updateSidebar)

import Models exposing (Model)
import Commands exposing (fetchArtist, fetchTopTracks, fetchRelatedArtists, fetchArtistById)
import Ports exposing (playAudio, pauseAudio, provideTracks, nextTrack, previousTrack, updateCurrentTime, updateVolume, initVis, destroyVis, addSimilar)
import RemoteData
import Routing exposing (parseLocation)
import Constants exposing (maxRelatedArtists)

import Helpers
import ModelHelpers



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
