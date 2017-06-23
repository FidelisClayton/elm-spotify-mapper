module MainContent.View.Pages exposing (..)

import Css exposing (property)
import CssClasses
import Explore.View.Explore as Explore
import Html exposing (Html, div)
import Html.Attributes
import Html.CssHelpers
import Models exposing (Model)
import Msgs exposing (Msg)
import Search.View as Search


{ class } =
    Html.CssHelpers.withNamespace ""


page : Model -> List (Html Msg)
page model =
    case model.route of
        Models.SearchRoute ->
            Search.render model

        Models.ExploreRoute ->
            Explore.render model

        Models.NotFoundRoute ->
            Search.render model
