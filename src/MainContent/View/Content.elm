module MainContent.View.Content exposing (..)

import Css exposing (property)
import CssClasses
import Html exposing (Html, div)
import Html.Attributes
import Html.CssHelpers
import MainContent.View.Pages exposing (page)
import Models exposing (Model)
import Msgs exposing (Msg)
import Search.View as Search


{ class } =
    Html.CssHelpers.withNamespace ""


styles : List Css.Mixin -> Html.Attribute msg
styles =
    Css.asPairs >> Html.Attributes.style


render : Model -> Html Msg
render model =
    let
        backgroundStyle =
            if model.route == Models.SearchRoute then
                [ property "background-color" "#181818" ]
            else
                [ property "background-color" "transparent" ]
    in
    div
        [ class [ CssClasses.Main ]
        , styles backgroundStyle
        ]
        (page model)
