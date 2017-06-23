module Sidebar.View.Songs exposing (..)

import Constants
import Css exposing (property)
import CssClasses
import Html exposing (Html, a, button, div, i, img, input, span, text)
import Html.Attributes exposing (href, placeholder, src, target, type_)
import Html.CssHelpers
import Html.Events exposing (onClick)
import Models exposing (Model, TopTracks, Track)
import Msgs exposing (Msg)
import RemoteData exposing (WebData)
import Search.Msgs as Search exposing (SearchMsg)
import Sidebar.Msgs as Sidebar exposing (SidebarMsg)


{ class, id } =
    Html.CssHelpers.withNamespace ""


styles : List Css.Mixin -> Html.Attribute msg
styles =
    Css.asPairs >> Html.Attributes.style


songs : WebData TopTracks -> Html Msg
songs response =
    let
        html =
            case response of
                RemoteData.Success topTracks ->
                    List.map songItem topTracks.tracks

                RemoteData.Loading ->
                    [ text "Loading" ]

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
                [ i [ Html.Attributes.class "fa fa-play" ] [] ]
            , img
                [ src image ]
                []
            ]
        , div [ class [ CssClasses.SongDescription ] ]
            [ span [ class [ CssClasses.SongTitle ] ] [ text track.name ]
            , span [ class [ CssClasses.SongAlbumTitle ] ] [ text track.album.name ]
            ]
        ]
