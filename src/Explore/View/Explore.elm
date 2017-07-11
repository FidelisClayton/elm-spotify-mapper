module Explore.View.Explore exposing (..)

import CssClasses
import Explore.Msgs as Explore exposing (ExploreMsg)
import Explore.Style exposing (Classes(Active, Navbar, NavbarItem))
import Explore.View.SaveButton exposing (savePlaylistButton)
import Explore.View.Vis exposing (visContainer)
import Helpers exposing (cssClass)
import Html exposing (Html, a, div, i, text)
import Html.Attributes exposing (href)
import Html.CssHelpers
import Html.Events exposing (onClick)
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
