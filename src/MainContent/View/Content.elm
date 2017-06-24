module MainContent.View.Content exposing (..)

import Css exposing (property)
import Html exposing (Html, div)
import Html.Attributes
import Html.CssHelpers
import MainContent.Style exposing (Classes(Main))
import MainContent.View.Pages exposing (page)
import Models exposing (Model)
import Msgs exposing (Msg)
import Search.View.Search as Search
import MainContent.View.Navbar exposing (navbar)


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

        elements =
            case model.route of
                Models.SearchRoute ->
                    page model

                _ ->
                    (navbar model) :: (page model)
    in
        div
            [ class [ Main ]
            , styles backgroundStyle
            ]
            elements
