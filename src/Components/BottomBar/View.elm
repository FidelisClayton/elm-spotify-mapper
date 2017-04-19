module Components.BottomBar.View exposing (..)

import Html exposing (Html, div, text)
import Html.CssHelpers

import Models exposing (Model)
import Msgs exposing (Msg)

import CssClasses

{ class } =
  Html.CssHelpers.withNamespace ""

render : Model -> Html Msg
render model =
  div [ class [ CssClasses.BottomBar ] ]
      [ text "Bottom bar"]
