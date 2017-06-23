module Explore.View.SaveButton exposing (..)

import Explore.Msgs as Explore exposing (ExploreMsg)
import Explore.Style exposing (Classes(BtnSavePlaylist))
import Html exposing (Html, div, i, text)
import Html.Attributes
import Html.CssHelpers
import Html.Events exposing (onClick)
import Models exposing (Model)
import Msgs exposing (Msg)


{ class, id } =
    Html.CssHelpers.withNamespace ""


savePlaylistButton : Html Msg
savePlaylistButton =
    div
        [ class [ BtnSavePlaylist ]
        , onClick (Msgs.MsgForExplore Explore.SavePlaylist)
        ]
        [ i [ Html.Attributes.class "fa fa-plus" ] []
        ]
