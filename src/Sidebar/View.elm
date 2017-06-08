module Sidebar.View exposing (..)

import Html exposing (Html, div, text, input, span, img, i, button, a)
import Html.Attributes exposing (type_, placeholder, src, href, target)
import Html.Events exposing (onClick)
import Html.CssHelpers
import RemoteData exposing (WebData)
import Css exposing (property)

import Models exposing (Model, TopTracks, Track)
import Msgs exposing (Msg)
import Search.Msgs as Search exposing (SearchMsg)
import Sidebar.Msgs as Sidebar exposing (SidebarMsg)

import Constants

import CssClasses

{ class, id } =
  Html.CssHelpers.withNamespace ""

styles : List Css.Mixin -> Html.Attribute msg
styles =
  Css.asPairs >> Html.Attributes.style

navItem : List (Html Msg) -> Html Msg
navItem childrens =
  div [ class [ CssClasses.NavGroup ] ]
      childrens

artistSongs : WebData TopTracks -> Html Msg
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

songItem : Track -> Html Msg
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
      [ div [ class [ CssClasses.SongCover ], onClick (Msgs.MsgForSidebar (Sidebar.SelectTrack track)) ]
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

userProfile : Model -> Html Msg
userProfile model =
  let
    url = Constants.authUrl model.spotifyConfig.clientId model.spotifyConfig.redirectUri
  in
    case model.user of
      RemoteData.Success user ->
        navItem
          [ div [ class [ CssClasses.UserProfile ] ]
              [ span [ class [ CssClasses.FontMedium ] ]
                  [ text user.displayName ]
              ]
          ]

      _ ->
        navItem
          [ div [ class [ CssClasses.UserProfile ], id [ CssClasses.TutLogin ] ]
              [ span [ class [ CssClasses.FontMedium ] ]
                  [ a [ href url, target "blank" ] [ text "Login" ]
                  ]
              ]
          ]

bigSearch : Model -> Html Msg
bigSearch model =
  div [ class [ CssClasses.BigSearch ] ]
    [ input [ type_ "text" ] [] ]

render : Model -> Html Msg
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
              , id [ CssClasses.TutSearch ]
              ]
              [ text "Search" ]
          , a
              [ class exploreClasses
              , href "#/explore"
              , id [ CssClasses.TutExplore ]
              ]
              [ text "Explore" ]
          ]
      , artistSongs model.topTracks
      , userProfile model
      ]
