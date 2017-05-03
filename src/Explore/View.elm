module Explore.View exposing (..)

import Html exposing (Html, div, text)
import Html.CssHelpers

import Msgs exposing(ExploreMsg)
import Models exposing (Model)
import CssClasses

{ class, id } =
  Html.CssHelpers.withNamespace ""

visContainer : Html ExploreMsg
visContainer =
  div [ id [ CssClasses.VisContainer ] ]
      []

render : Model -> List (Html ExploreMsg)
render model =
  [ visContainer ]
