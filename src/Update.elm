module Update exposing (..)

import BottomBar.Update exposing (updatePlayer)
import Dialog.Update exposing (updateDialog)
import Explore.Update exposing (updateExplore)
import FlashMessage.Update exposing (updateFlashMessage)
import Helpers
import Models exposing (Model)
import Msgs exposing (Msg)
import Ports exposing (destroyVis, initVis)
import Routing exposing (parseLocation)
import Search.Update exposing (updateSearch)
import Sidebar.Update exposing (updateSidebar)
import Spotify.Api exposing (getMe)
import Spotify.Update exposing (updateSpotify)
import Tutorial.Msgs as Tutorial
import Tutorial.Update exposing (updateTutorial)


update : Msg -> Model -> ( Model, Cmd Msg )
update msgFor model =
    case msgFor of
        Msgs.MsgForDialog msgFor ->
            updateDialog msgFor model

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
                newRoute =
                    parseLocation location
            in
            case newRoute of
                Models.ExploreRoute ->
                    let
                        previousNetwork =
                            model.network

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
                                        ( model, previousNetwork )
                                    else
                                        ( { model | playlistArtists = [] }, { previousNetwork | nodes = [ selectedArtistNode ], edges = [] } )

                                Nothing ->
                                    ( { model | playlistArtists = [] }, { previousNetwork | nodes = [ selectedArtistNode ], edges = [] } )

                        newModel =
                            Tuple.first newData

                        newNetwork =
                            Tuple.second newData

                        steps =
                            [ Tutorial.explore
                            , Tutorial.nodeTree
                            , Tutorial.sidebarTrack
                            , Tutorial.savePlaylist
                            , Tutorial.login
                            ]

                        cmds =
                            [ Cmd.map Msgs.MsgForExplore (initVis newNetwork)
                            , Ports.addSteps steps
                            ]
                    in
                    { newModel | route = newRoute, network = newNetwork } ! cmds

                _ ->
                    ( { model | route = newRoute }, Cmd.map Msgs.MsgForExplore (destroyVis "") )
