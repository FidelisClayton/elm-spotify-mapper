module Explore.View.SaveButton exposing (..)

import CssClasses
import Explore.Msgs as Explore exposing (ExploreMsg)
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
        [ class [ CssClasses.SavePlaylist ]
        , onClick (Msgs.MsgForExplore Explore.SavePlaylist)
        ]
        [ i [ Html.Attributes.class "fa fa-plus" ] []
        ]
