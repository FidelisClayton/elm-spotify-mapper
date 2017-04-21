module Components.MainContent.View exposing (..)

import Html exposing (Html, div, text, input, label)
import Html.Attributes exposing (type_, placeholder, src)
import Html.CssHelpers

import Models exposing (Model)
import Msgs exposing (Msg)
import CssClasses

{ class } =
  Html.CssHelpers.withNamespace ""

bigSearch : Model -> Html Msg
bigSearch model =
  div [ class [ CssClasses.BigSearch ] ]
    [ label [] [ text "Search for an artist" ]
    , input [ type_ "text" ] [] ]

searchResults : Model -> Html Msg
searchResults model =
  div [ class [ CssClasses.SearchResults ] ]
    [ text "Results" ]

render : Model -> Html Msg
render model =
  div [ class [ CssClasses.Main ] ]
    [ bigSearch model
    , searchResults model
    ]
