module Components.Sidebar.View exposing (..)

import Html exposing (Html, div, text, input, span)
import Html.Attributes exposing (type_, placeholder)
import Html.CssHelpers

import Models exposing (Model)
import Msgs exposing (Msg)

import CssClasses

{ class } =
  Html.CssHelpers.withNamespace ""

navItem : List (Html Msg) -> Html Msg
navItem childrens =
  div [ class [ CssClasses.NavGroup ] ]
      childrens

render : Model -> Html Msg
render model =
  div [ class [ CssClasses.Sidebar ] ]
      [ navItem
          [ span [ class [ CssClasses.Logo] ]
              [ text "Spotify Mapper" ] 
          ]
      , navItem
          [ input
              [ type_ "text"
              , class [ CssClasses.SearchInput ]
              , placeholder "Search"
              ]
              []
          ]
      ]
