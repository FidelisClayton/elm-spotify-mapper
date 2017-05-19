module Main exposing (..)

import Html exposing (Html, text, div)
import Html.CssHelpers
import Navigation exposing (Location)

import BottomBar.View as BottomBar
import Sidebar.View as Sidebar
import MainContent.View as MainContent
import FlashMessage.View as FlashMessage

import Msgs exposing (Msg)
import Sidebar.Msgs as Sidebar exposing (SidebarMsg)
import BottomBar.Msgs as Player exposing (PlayerMsg)
import Explore.Msgs as Explore exposing (ExploreMsg)

import Models exposing (Model, Flags)
import Update exposing (update)
import CssClasses
import Routing
import Ports exposing (audioEnded, updateCurrentTrack, updateAudioStatus, onNodeClick, updateNetwork, onDoubleClick, fromStorage)

import Spotify.Api

{ class } =
  Html.CssHelpers.withNamespace ""

init : Flags -> Location -> ( Models.Model, Cmd Msg )
init flags location =
  let
    currentRoute = Routing.parseLocation location

    cmd =
      case flags.auth of
        Just auth ->
          Cmd.map Msgs.MsgForSpotify (Spotify.Api.getMe auth.accessToken)

        Nothing ->
          Cmd.none
  in
    ( Models.initialModel currentRoute flags, cmd )

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
  div [ class [ CssClasses.Container ]]
      [ div [ class [ CssClasses.Content ] ]
          [ Sidebar.render model
          , FlashMessage.render model
          , MainContent.render model
          ]
      , BottomBar.render model
      ]

main : Program Flags Model Msg
main =
  Navigation.programWithFlags Msgs.OnLocationChange
    { init = init
    , view = view
    , subscriptions = subscriptions
    , update = update
    }
