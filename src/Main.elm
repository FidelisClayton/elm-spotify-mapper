module Main exposing (class, init, main, subscriptions, view)

import BottomBar.Msgs as Player exposing (PlayerMsg)
import BottomBar.View.Player as BottomBar
import CssClasses
import Dialog.View.Modal as Dialog
import Explore.Msgs as Explore exposing (ExploreMsg)
import FlashMessage.View.Message as FlashMessage
import Html exposing (Html, div, text)
import Html.CssHelpers
import MainContent.View.Content as MainContent
import Models exposing (Flags, Model)
import Msgs exposing (Msg)
import Navigation exposing (Location)
import Ports exposing (audioEnded, fromStorage, initTutorial, onDoubleClick, onNodeClick, updateAudioStatus, updateCurrentTrack, updateNetwork)
import Routing
import Sidebar.Msgs as Sidebar exposing (SidebarMsg)
import Sidebar.View.Sidebar as Sidebar
import Spotify.Api
import Update exposing (update)


{ class } =
    Html.CssHelpers.withNamespace ""


init : Flags -> Location -> ( Models.Model, Cmd Msg )
init flags location =
    let
        currentRoute =
            Routing.parseLocation location

        initialModel =
            Models.initialModel currentRoute flags

        cmds =
            case flags.auth of
                Just auth ->
                    [ Cmd.map Msgs.MsgForSpotify (Spotify.Api.getMe auth.accessToken)
                    , Cmd.map Msgs.MsgForSpotify (Spotify.Api.getClientToken flags.spotifyConfig.clientId flags.spotifyConfig.clientSecret)
                    ]

                Nothing ->
                    [ Cmd.map Msgs.MsgForSpotify (Spotify.Api.getClientToken flags.spotifyConfig.clientId flags.spotifyConfig.clientSecret)
                    ]
    in
    ( initialModel, Cmd.batch cmds )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Sub.map Msgs.MsgForPlayer (audioEnded Player.Stop)
        , Sub.map Msgs.MsgForSidebar (updateCurrentTrack Sidebar.SelectTrack)
        , Sub.map Msgs.MsgForPlayer (updateAudioStatus Player.UpdateAudioStatus)
        , Sub.map Msgs.MsgForExplore (onNodeClick Explore.OnVisNodeClick)
        , Sub.map Msgs.MsgForExplore (updateNetwork Explore.UpdateNetwork)
        , Sub.map Msgs.MsgForExplore (onDoubleClick Explore.OnDoubleClick)
        , fromStorage Msgs.UpdateAuthData
        ]


view : Model -> Html Msg
view model =
    div [ class [ CssClasses.Container ] ]
        [ div [ class [ CssClasses.Content ] ]
            [ Sidebar.render model
            , FlashMessage.render model
            , MainContent.render model
            ]
        , BottomBar.render model
        , Dialog.render model
        ]


main : Program Flags Model Msg
main =
    Navigation.programWithFlags Msgs.OnLocationChange
        { init = init
        , view = view
        , subscriptions = subscriptions
        , update = update
        }
