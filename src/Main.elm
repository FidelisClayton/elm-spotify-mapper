module Main exposing (..)

import Html exposing (Html, text, div)
import Html.CssHelpers

import Components.BottomBar.View as BottomBar
import Components.Sidebar.View as Sidebar
import Components.MainContent.View as MainContent

import Msgs exposing (Msg)
import Models exposing (Model)
import Update exposing (update)
import CssClasses
import Ports exposing (audioEnded, updateCurrentTrack, updateAudioStatus)

{ class } =
  Html.CssHelpers.withNamespace ""

init : ( Models.Model, Cmd Msg )
init =
  ( Models.initialModel, Cmd.none )

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.batch
    [ audioEnded Msgs.Stop
    , updateCurrentTrack Msgs.SelectTrack
    , updateAudioStatus Msgs.UpdateAudioStatus
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
  Html.program
    { init = init
    , view = view
    , subscriptions = subscriptions
    , update = update
    }
