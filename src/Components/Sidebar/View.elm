module Components.Sidebar.View exposing (..)

import Html exposing (Html, div, text, input, span, img, i, button)
import Html.Attributes exposing (type_, placeholder, src)
import Html.Events exposing (onClick)
import Html.CssHelpers
import RemoteData exposing (WebData)

import Models exposing (Model, TopTracks, Track)
import Msgs exposing (Msg)

import CssClasses

{ class } =
  Html.CssHelpers.withNamespace ""

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

userProfile : Model -> Html Msg
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

bigSearch : Model -> Html Msg
bigSearch model =
  div [ class [ CssClasses.BigSearch ] ]
    [ input [ type_ "text" ] [] ]

render : Model -> Html Msg
render model =
  div [ class [ CssClasses.Sidebar ] ]
      [ navItem
          [ span [ class [ CssClasses.Logo] ]
              [ i [ Html.Attributes.class "fa fa-spotify" ] [] ]
          ]
      , navItem
          [ input
              [ type_ "text"
              , class [ CssClasses.SearchInput ]
              , placeholder "Search"
              , onClick Msgs.StartSearch
              ]
              []
          ]
      , artistSongs model.topTracks
      , userProfile model
      ]
