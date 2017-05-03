module Sidebar.View exposing (..)

import Html exposing (Html, div, text, input, span, img, i, button, a)
import Html.Attributes exposing (type_, placeholder, src, href)
import Html.Events exposing (onClick)
import Html.CssHelpers
import RemoteData exposing (WebData)
import Css exposing (property)

import Models exposing (Model, TopTracks, Track)
import Msgs exposing (SidebarMsg)

import CssClasses

{ class } =
  Html.CssHelpers.withNamespace ""

styles : List Css.Mixin -> Html.Attribute msg
styles =
  Css.asPairs >> Html.Attributes.style

navItem : List (Html SidebarMsg) -> Html SidebarMsg
navItem childrens =
  div [ class [ CssClasses.NavGroup ] ]
      childrens

artistSongs : WebData TopTracks -> Html SidebarMsg
artistSongs response =
  let
    html =
      case response of
        RemoteData.Success topTracks ->
          List.map songItem topTracks.tracks

        RemoteData.Loading ->
          [text "Loading"]

        _ ->
          []
  in
    div [ class [ CssClasses.NavGroup, CssClasses.Songs ] ]
      html

songItem : Track -> Html SidebarMsg
songItem track =
  let
    image =
      case List.head track.album.images of
        Just image ->
          image.url

        Nothing ->
          ""
  in
    div [ class [ CssClasses.SongItem ] ]
      [ div [ class [ CssClasses.SongCover ], onClick (Msgs.SelectTrack track) ]
          [ button []
              [ i [ Html.Attributes.class "fa fa-play"] []]
          , img
              [ src image ]
              []
          ]
      , div [ class [ CssClasses.SongDescription ] ]
          [ span [ class [ CssClasses.SongTitle ] ] [ text track.name ]
          , span [ class [ CssClasses.SongAlbumTitle ] ] [ text track.album.name ]
          ]
      ]

userProfile : Model -> Html SidebarMsg
userProfile model =
  navItem
    [ div [ class [ CssClasses.UserProfile ] ]
        [ img
            [ src "http://i3.kym-cdn.com/photos/images/facebook/000/120/409/03e.png"
            , class [ CssClasses.RoundedImage, CssClasses.UserImage ]
            ] []
        , span [ class [ CssClasses.FontMedium ] ]
            [ text "Gabe Newell" ]
        ]
    ]

bigSearch : Model -> Html SidebarMsg
bigSearch model =
  div [ class [ CssClasses.BigSearch ] ]
    [ input [ type_ "text" ] [] ]

render : Model -> Html SidebarMsg
render model =
  let
    backgroundStyle =
      if model.route == Models.SearchRoute then
        [ property "background" "black" ]
      else
        []

    searchClasses =
      if model.route == Models.SearchRoute then
        [ CssClasses.SidebarLink, CssClasses.Active ]
      else
        [ CssClasses.SidebarLink ]

    exploreClasses =
      if model.route == Models.ExploreRoute then
        [ CssClasses.SidebarLink, CssClasses.Active ]
      else
        [ CssClasses.SidebarLink ]
  in
    div
      [ class [ CssClasses.Sidebar ]
      , styles backgroundStyle
      ]
      [ navItem
          [ span [ class [ CssClasses.Logo] ]
              [ i [ Html.Attributes.class "fa fa-spotify" ] [] ]
          ]
      , navItem
          [ a
              [ class searchClasses
              , href "#/search"
              ]
              [ text "Search" ]
          , a
              [ class exploreClasses
              , href "#/explore"
              ]
              [ text "Explore" ]
          ]
      , artistSongs model.topTracks
      , userProfile model
      ]
