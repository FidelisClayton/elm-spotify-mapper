module Components.Navbar.View exposing (..)

import Html exposing (Html, nav, text, input, button)
import Html.Attributes exposing (type_, placeholder)
import Html.Events exposing (onClick)
import Html.CssHelpers

import Models exposing (Model)
import Msgs exposing (Msg)

import CssClasses

{ class } =
  Html.CssHelpers.withNamespace ""

render : Model -> Html Msg
render model =
  nav
    [ class [ CssClasses.Navbar ] ]
    [ button [ class [ CssClasses.MenuToggler ], onClick Msgs.ToggleSidebar ] [ text <| toString model.showMenu ]
    , text "Spotify Mapper"
    , input [ type_ "text", placeholder "Search artist" ] []
    ]
