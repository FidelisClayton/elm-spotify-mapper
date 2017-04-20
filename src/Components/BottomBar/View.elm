module Components.BottomBar.View exposing (..)

import Html exposing (Html, div, text, span)
import Html.CssHelpers

import Models exposing (Model)
import Msgs exposing (Msg)

import CssClasses

{ class } =
  Html.CssHelpers.withNamespace ""

controlIcon : Html Msg
controlIcon =
  div [ class [ CssClasses.ControlIcon] ]
      []

progressBar : Float -> Html Msg
progressBar progress =
  div [ class [ CssClasses.ProgressBar ] ]
      [ div [ class [ CssClasses.Progress ] ]
          []
      ]

progress : Model -> Html Msg
progress model =
  div [ class [ CssClasses.ProgressGroup ] ]
      [ span [ class [ CssClasses.FontSmall ] ]
          [ text "2:00" ]
      , progressBar 10
      , span [ class [ CssClasses.FontSmall ] ]
          [ text "2:00" ]
      ]

controls : Model -> Html Msg
controls model =
  div [ class [ CssClasses.Controls ] ]
      [ div [ class [ CssClasses.ControlButtons ] ]
          [ controlIcon
          , controlIcon
          , controlIcon
          ]
      , progress model
      ]

render : Model -> Html Msg
render model =
  div [ class [ CssClasses.BottomBar ] ]
      [ controls model ]
