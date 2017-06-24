module Playlist.View.Playlist exposing (..)

import Html exposing (Html, text, div)
import Msgs exposing (Msg)
import Models exposing (Model)
import Playlist.View.Info exposing (playlistInfo)


render : Model -> List (Html Msg)
render model =
    [ playlistInfo model
    ]
