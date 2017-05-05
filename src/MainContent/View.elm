module MainContent.View exposing (..)

import Html exposing (Html, div)
import Html.Attributes
import Html.CssHelpers

import Models exposing (Model)
import Msgs exposing (Msg)
import CssClasses
import Css exposing (property)

import Search.View as Search
import Explore.View as Explore

{ class } =
  Html.CssHelpers.withNamespace ""

styles : List Css.Mixin -> Html.Attribute msg
styles =
  Css.asPairs >> Html.Attributes.style

page : Model -> List (Html Msg)
page model =
  case model.route of
    Models.SearchRoute ->
      Search.render model

    Models.ExploreRoute ->
      Explore.render model

    Models.NotFoundRoute ->
      Search.render model

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
