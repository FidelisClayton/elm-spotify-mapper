module Explore.View.Explore exposing (..)

import Explore.View.SaveButton exposing (savePlaylistButton)
import Explore.View.Vis exposing (visContainer)
import Html exposing (Html, a, div, i, text)
import Models exposing (Model)
import Msgs exposing (Msg)
import RemoteData


render : Model -> List (Html Msg)
render model =
    let
        savePlaylistBtn =
            case model.user of
                RemoteData.Success user ->
                    [ savePlaylistButton ]

                _ ->
                    []
    in
    List.append savePlaylistBtn [ visContainer ]
