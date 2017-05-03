module Main exposing (..)

import Html exposing (Html, text, div)
import Html.CssHelpers
import Navigation exposing (Location)

import BottomBar.View as BottomBar
import Sidebar.View as Sidebar
import MainContent.View as MainContent

import Msgs exposing (Msg)
import Models exposing (Model)
import Update exposing (update)
import CssClasses
import Routing
import Ports exposing (audioEnded, updateCurrentTrack, updateAudioStatus, onNodeClick, updateNetwork, onDoubleClick)

{ class } =
  Html.CssHelpers.withNamespace ""

init : Location -> ( Models.Model, Cmd Msg )
init location =
  let
    currentRoute = Routing.parseLocation location
  in
    ( Models.initialModel currentRoute, Cmd.none )

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.batch
    [ Sub.map Msgs.MsgForPlayer (audioEnded Msgs.Stop)
    , Sub.map Msgs.MsgForSidebar (updateCurrentTrack Msgs.SelectTrack)
    , Sub.map Msgs.MsgForPlayer (updateAudioStatus Msgs.UpdateAudioStatus)
    , Sub.map Msgs.MsgForExplore (onNodeClick Msgs.OnVisNodeClick)
    , Sub.map Msgs.MsgForExplore (updateNetwork Msgs.UpdateNetwork)
    , Sub.map Msgs.MsgForExplore (onDoubleClick Msgs.OnDoubleClick)
    ]

view : Model -> Html Msg
view model =
  div [ class [ CssClasses.Container ]]
      [ div [ class [ CssClasses.Content ] ]
          [ Sidebar.render model
          , MainContent.render model
          ]
      , BottomBar.render model
      ]

main : Program Never Model Msg
main =
  Navigation.program Msgs.OnLocationChange
    { init = init
    , view = view
    , subscriptions = subscriptions
    , update = update
    }
