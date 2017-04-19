module Components.Sidebar.View exposing (..)

import Html exposing (Html, div, text)
import Html.CssHelpers

import Models exposing (Model)
import Msgs exposing (Msg)

import CssClasses

{ class } =
  Html.CssHelpers.withNamespace ""

render : Model -> Html Msg
render model =
  if model.showMenu then
    div [ class [ CssClasses.Sidebar ] ] [ text "Sidebar" ]
  else
    div [ class [ CssClasses.Sidebar, CssClasses.SidebarActive ] ] [ text "Sidebar" ]
