module Explore.View exposing (..)

import Html exposing (Html, div, text)

import Msgs exposing(Msg)
import Models exposing (Model)

render : Model -> List (Html Msg)
render model =
  [ text "Explore" ]
