module Explore.View exposing (..)

import Html exposing (Html, div, text)
import Html.CssHelpers

import Msgs exposing(Msg)
import Models exposing (Model)
import CssClasses

{ class, id } =
  Html.CssHelpers.withNamespace ""

visContainer : Html Msg
visContainer =
  div [ id [ CssClasses.VisContainer ] ]
      []

render : Model -> List (Html Msg)
render model =
  [ visContainer ]
