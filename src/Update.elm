module Update exposing (..)

import Msgs exposing (Msg)

import BottomBar.Update exposing (updatePlayer)
import Explore.Update exposing (updateExplore)
import Sidebar.Update exposing (updateSidebar)
import Search.Update exposing (updateSearch)
import Spotify.Update exposing (updateSpotify)
import FlashMessage.Update exposing (updateFlashMessage)
import Tutorial.Update exposing (updateTutorial)

import Spotify.Api exposing (getMe)

import Models exposing (Model)
import Ports exposing (initVis, destroyVis)
import Routing exposing (parseLocation)

import Helpers

update : Msg -> Model -> (Model, Cmd Msg)
update msgFor model =
  case msgFor of
    Msgs.MsgForFlashMessage msgFor ->
      updateFlashMessage msgFor model

    Msgs.UpdateAuthData data ->
      let
        cmd =
          case data of
            Just auth ->
              Cmd.map Msgs.MsgForSpotify (getMe auth.accessToken)

            Nothing ->
              Cmd.none
      in
        { model | auth = data } ! [ cmd ]

    Msgs.MsgForSpotify msgFor ->
      updateSpotify msgFor model

    Msgs.MsgForPlayer msgFor ->
      updatePlayer msgFor model

    Msgs.MsgForSidebar msgFor ->
      updateSidebar msgFor model

    Msgs.MsgForExplore msgFor ->
      updateExplore msgFor model

    Msgs.MsgForSearch msgFor ->
      updateSearch msgFor model

    Msgs.MsgForTutorial msgFor ->
      updateTutorial msgFor model

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

              steps = [
                { id = "explore"
                , title = "Explore artists"
                , text = "This is the Explore section, here you can discover new artists from the previously selected"
                , attachTo = "#TutExplore right"
                , done = False
                , advanceOn = Nothing
                }
              , { id = "node-tree"
                , title = "Artist node"
                , text = "You can click on this circle to find similar artists. You also can click twice to start to play the artist top tracks."
                , attachTo = ".Main center"
                , done = False
                , advanceOn = Nothing
                }
              , { id = "sidebar-track"
                , title = "Tracks"
                , text = "Here is the list of the artist top tracks. Click on the track cover to play it."
                , attachTo = ".SongItem right"
                , done = False
                , advanceOn = Nothing
                }
              , { id = "save-playlist"
                , title = "Save playlist"
                , text = "Use this button to save your playlist (you must be logged in)."
                , attachTo = ".SavePlaylist left"
                , done = False
                , advanceOn = Nothing
                }
              , { id = "login"
                , title = "Login"
                , text = "You also can log in to be able to save your playlist."
                , attachTo = "#TutLogin right"
                , done = False
                , advanceOn = Nothing
                }
              ]

              cmds =
                [ Cmd.map Msgs.MsgForExplore (initVis newNetwork)
                , Ports.addSteps steps
                ]
            in
              { newModel | route = newRoute, network = newNetwork } ! cmds

          _ ->
            ({ model | route = newRoute }, Cmd.map Msgs.MsgForExplore (destroyVis ""))
