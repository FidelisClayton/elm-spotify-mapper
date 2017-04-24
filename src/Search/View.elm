module Search.View exposing (..)

import Html exposing (Html, div, text, input, label, img, i, a)
import Html.Attributes exposing (type_, placeholder, src, href)
import Html.Events exposing (onInput, onClick)
import Html.CssHelpers
import RemoteData exposing (WebData)

import Models exposing (Model, Artist, SearchArtistData)
import Msgs exposing (Msg)
import CssClasses

{ class } =
  Html.CssHelpers.withNamespace ""

bigSearch : Model -> Html Msg
bigSearch model =
  div [ class [ CssClasses.BigSearch ] ]
    [ label [] [ text "Search for an artist" ]
    , input
        [ type_ "text"
        , onInput Msgs.Search ]
        []
    ]

searchResult : Artist -> Html Msg
searchResult artist =
  let
    image =
      case (List.head artist.images) of
        Just image ->
          image.url

        Nothing ->
          "http://www.the-music-shop.com/wp-content/uploads/2015/02/placeholder.png"
  in
    a [ class [ CssClasses.ArtistResult ], onClick (Msgs.SelectArtist artist), href "#/explore" ]
      [ div [ class [ CssClasses.ImageWrapper ] ]
            [ div []
                [ i [ Html.Attributes.class "fa fa-play" ] [] ]
            , img [ src image ] []
            ]
      , label [] [ text artist.name ]
      ]

searchResults : WebData SearchArtistData -> Html Msg
searchResults response =
  let
    html =
      case response of
        RemoteData.NotAsked ->
          [ text "" ]

        RemoteData.Loading ->
          [ text "Loading" ]

        RemoteData.Success data ->
          List.map searchResult data.items

        RemoteData.Failure error ->
          [ text "" ]
  in
    div [ class [ CssClasses.SearchResults ] ]
      html

render : Model -> List (Html Msg)
render model =
  [ bigSearch model
  , searchResults model.artists
  ]

