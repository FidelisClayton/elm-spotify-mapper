module Search.View.Search exposing (..)

import CssClasses exposing (Ids(TutSearchInput))
import Html exposing (Html, a, div, i, img, input, label, text)
import Html.Attributes exposing (href, placeholder, src, type_)
import Html.CssHelpers
import Html.Events exposing (on, onClick, onInput, targetValue)
import Json.Decode as Json
import Models exposing (Artist, Model, SearchArtistData)
import Msgs exposing (Msg)
import RemoteData exposing (WebData)
import Search.Msgs as Search exposing (SearchMsg)
import Search.Style exposing (Classes(ArtistResult, BigSearch, ImageWrapper, SearchResults, Image, Play))


{ class, id } =
    Html.CssHelpers.withNamespace ""


bigSearch : Model -> Html Msg
bigSearch model =
    div [ class [ BigSearch ] ]
        [ label [] [ text "Search for an artist" ]
        , input
            [ type_ "text"
            , on "input" (Json.map (Msgs.MsgForSearch << Search.Search) targetValue)
            , id [ TutSearchInput ]
            ]
            []
        ]


searchResult : Artist -> Html Msg
searchResult artist =
    let
        image =
            case List.head artist.images of
                Just image ->
                    image.url

                Nothing ->
                    "http://www.the-music-shop.com/wp-content/uploads/2015/02/placeholder.png"
    in
    a [ class [ ArtistResult ], onClick (Msgs.MsgForSearch (Search.SelectArtist artist)), href "#/explore" ]
        [ div [ class [ ImageWrapper ] ]
            [ div [ class [ Play ]]
                [ i [ Html.Attributes.class "fa fa-play" ] [] ]
            , div [ class [ Image ], Html.Attributes.style [("background-image", "url(" ++ image ++ ")")] ] []
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
    div [ class [ SearchResults ] ]
        html


render : Model -> List (Html Msg)
render model =
    [ bigSearch model
    , searchResults model.artists
    ]
