module Explore.View.Vis exposing (..)

import CssClasses
import Explore.Msgs as Explore exposing (ExploreMsg)
import Html exposing (Html, div, i, text)
import Html.Attributes
import Html.CssHelpers
import Html.Events exposing (onClick)
import Models exposing (Model)
import Msgs exposing (Msg)


{ class, id } =
    Html.CssHelpers.withNamespace ""


visContainer : Html Msg
visContainer =
    div
        [ id [ CssClasses.VisContainer ]
        , class [ CssClasses.VisContainer ]
        ]
        []
