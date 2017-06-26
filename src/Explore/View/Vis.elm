module Explore.View.Vis exposing (..)

import CssClasses
import Explore.Msgs as Explore exposing (ExploreMsg)
import Explore.Style exposing (Classes(VisContainer))
import Helpers exposing (cssClass, cssId)
import Html exposing (Html, div, i, text)
import Html.Attributes
import Html.CssHelpers
import Html.Events exposing (onClick)
import Models exposing (Model)
import Msgs exposing (Msg)


visContainer : Html Msg
visContainer =
    div
        [ cssId [ VisContainer ]
        , cssClass [ VisContainer ]
        ]
        []
