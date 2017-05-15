module Explore.View exposing (..)

import Html exposing (Html, div, text, i)
import Html.Attributes
import Html.Events exposing (onClick)
import Html.CssHelpers

import Msgs exposing(Msg)
import Explore.Msgs as Explore exposing (ExploreMsg)
import Models exposing (Model)
import CssClasses

{ class, id } =
  Html.CssHelpers.withNamespace ""

visContainer : Html Msg
visContainer =
  div [ id [ CssClasses.VisContainer ] ]
      []

savePlaylistButton : Model -> Html Msg
savePlaylistButton model =
  div [ class [ CssClasses.SavePlaylist ]
      , onClick (Msgs.MsgForExplore Explore.AddTracks)
      ]
      [ i [ Html.Attributes.class "fa fa-plus" ] []
      ]

render : Model -> List (Html Msg)
render model =
  [ savePlaylistButton model
  , visContainer
  ]
