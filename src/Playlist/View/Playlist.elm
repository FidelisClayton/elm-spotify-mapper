module Playlist.View.Playlist exposing (..)

import Html exposing (Html, text, div)
import Msgs exposing (Msg)
import Models exposing (Model)

render : Model -> List (Html Msg)
render model =
    [ div []
        [ text "Playlist" ]
    ]
