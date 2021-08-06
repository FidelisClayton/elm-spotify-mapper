module Sidebar.View.Sidebar exposing (..)

import Constants
import Css exposing (property)
import Html exposing (Html, a, button, div, i, img, input, span, text)
import Html.Attributes exposing (href, placeholder, src, target, type_)
import Html.CssHelpers
import Html.Events exposing (onClick)
import Models exposing (Model, TopTracks, Track)
import Msgs exposing (Msg)
import RemoteData exposing (WebData)
import Search.Msgs as Search exposing (SearchMsg)
import Sidebar.Msgs as Sidebar exposing (SidebarMsg)
import Sidebar.Style exposing (Classes(Sidebar))
import Sidebar.View.LoginProfile exposing (maybeUser)
import Sidebar.View.Navigation exposing (navItem, navMenu)
import Sidebar.View.Songs exposing (songs)


{ class, id } =
    Html.CssHelpers.withNamespace ""


styles =
    Css.asPairs >> Html.Attributes.style


render : Model -> Html Msg
render model =
    let
        backgroundStyle =
            if model.route == Models.SearchRoute then
                [ property "background" "black" ]
            else
                []
    in
    div
        [ class [ Sidebar ]
        , styles backgroundStyle
        ]
        [ navMenu model
        , songs model.topTracks
        , maybeUser model
        ]
