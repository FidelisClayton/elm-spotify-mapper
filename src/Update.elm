module Update exposing (..)

import Msgs exposing (Msg)

import BottomBar.Update exposing (updatePlayer)
import Explore.Update exposing (updateExplore)
import Sidebar.Update exposing (updateSidebar)
import Search.Update exposing (updateSearch)

import Models exposing (Model)
import Ports exposing (initVis, destroyVis)
import Routing exposing (parseLocation)

import Helpers

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
