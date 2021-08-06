module MainContent.View.Content exposing (..)

import Css exposing (property)
import Html exposing (Html, div)
import Html.Attributes
import Html.CssHelpers
import MainContent.Style exposing (Classes(Main))
import MainContent.View.Navbar exposing (navbar)
import MainContent.View.Pages exposing (page)
import Models exposing (Model)
import Msgs exposing (Msg)
import RemoteData
import Search.View.Search as Search


{ class } =
    Html.CssHelpers.withNamespace ""


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

        shouldRenderNavbar =
            case model.user of
                RemoteData.Success user ->
                    [ navbar model ]

                _ ->
                    []

        elements =
            case model.route of
                Models.SearchRoute ->
                    page model

                _ ->
                    List.append shouldRenderNavbar (page model)
    in
    div
        [ class [ Main ]
        , styles backgroundStyle
        ]
        elements
