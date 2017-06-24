module Playlist.Style exposing (..)

import Css exposing (..)
import Css.Elements exposing (div)
import Css.Namespace exposing (namespace)
import Html.CssHelpers exposing (withNamespace)


type Classes
    = PlaylistInfo
    | PlaylistCover
    | PlaylistTitle
    | PlaylistDescription
    | BtnSave


css =
    (stylesheet << namespace "")
        [ class PlaylistInfo
            [ width <| px 200
            , marginLeft <| px 20
            , marginRight <| px 20
            , displayFlex
            , flexDirection column
            , flex <| int 1
            , alignItems center
            ]
        , class PlaylistCover
            [ width <| px 200
            ]
        , class PlaylistTitle
            [ color <| hex "fff"
            , textAlign center
            , fontSize <| pt 18
            , margin2 (px 12) zero
            ]
        , class PlaylistDescription
            [ color <| rgba 255 255 255 0.5
            , fontSize <| pt 11
            , textAlign center
            , marginTop zero
            ]
        , class BtnSave
            [ width <| px 150
            , height <| px 40
            , border zero
            , borderRadius <| px 20
            , backgroundColor <| hex "1ed760"
            , color <| hex "fff"
            , textTransform uppercase
            , letterSpacing <| px 2
            , property "transition" "0.2s ease transform"
            , hover
                [ cursor pointer
                , property "transform" "scale(1.05)"
                ]
            ]
        ]
