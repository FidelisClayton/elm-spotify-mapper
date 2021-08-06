module Playlist.View.Info exposing (..)

import Html exposing (Html, div, text, p, h3, img, button)
import Html.Attributes exposing (src)
import Html.Events exposing (onClick)
import Explore.Msgs as Explore
import Models exposing (Model)
import Msgs exposing (Msg)
import Playlist.Style exposing (Classes(PlaylistInfo, PlaylistTitle, PlaylistCover, PlaylistDescription, BtnSave))
import Helpers exposing (cssClass)


playlistInfo : Model -> Html Msg
playlistInfo model =
    div [ cssClass [ PlaylistInfo ] ]
        [ div
            [ cssClass [ PlaylistCover ]
            , Html.Attributes.style [("background-image", "url(" ++ model.playlist.cover ++ ")")]
            ]
            []
        , h3
            [ cssClass [ PlaylistTitle ] ]
            [ text model.playlist.name ]
        , p
            [ cssClass [ PlaylistDescription ] ]
            [ text model.playlist.description ]
        , button
            [ cssClass [ BtnSave ]
            , onClick (Msgs.MsgForExplore Explore.SavePlaylist)
            ]
            [ text "Save" ]
        ]
