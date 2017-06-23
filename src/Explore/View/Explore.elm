module Explore.View.Explore exposing (..)

import CssClasses
import Explore.Msgs as Explore exposing (ExploreMsg)
import Explore.View.SaveButton exposing (savePlaylistButton)
import Explore.View.Vis exposing (visContainer)
import Html exposing (Html, div, i, text)
import Html.Attributes
import Html.CssHelpers
import Html.Events exposing (onClick)
import Models exposing (Model)
import Msgs exposing (Msg)


{ class, id } =
    Html.CssHelpers.withNamespace ""


render : Model -> List (Html Msg)
render model =
    [ savePlaylistButton
    , visContainer
    ]
