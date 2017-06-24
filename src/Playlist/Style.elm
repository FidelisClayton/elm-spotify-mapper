module Playlist.Style exposing (..)

import Css exposing (..)
import Css.Elements exposing (div, span)
import Css.Namespace exposing (namespace)
import Html.CssHelpers exposing (withNamespace)


type Classes
    = PlaylistPage
    | PlaylistInfo
    | PlaylistCover
    | PlaylistTitle
    | PlaylistDescription
    | BtnSave
    | PlaylistSongs
    | Song
    | SongName
    | SongInfo
    | SongArtist
    | SongNumber
    | SongLength
    | SongPlaying
    | Icons
    | SpeakerIcon
    | PauseIcon
    | PlayIcon


css =
    (stylesheet << namespace "")
        [ class PlaylistPage
            [ displayFlex
            ]
        , class PlaylistInfo
            [ width <| px 200
            , marginLeft <| px 20
            , marginRight <| px 20
            , displayFlex
            , flexDirection column
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
        , class PlaylistSongs
            []
        , class Song
            [ displayFlex
            , color <| hex "FFF"
            , padding <| px 10
            , cursor default
            , property "transition" "0.3s ease background-color"
            , hover
                [ backgroundColor <| rgba 0 0 0 0.5
                , descendants
                    [ class SongNumber
                        [ display none
                        ]
                    , class Icons
                        [ display block
                        , children
                            [ class PlayIcon
                                [ display inline
                                , cursor pointer
                                ]
                            ]
                        ]
                    ]
                ]
            , withClass SongPlaying
                [ descendants
                    [ class SongNumber
                        [ display none
                        ]
                    , class SongName
                        [ color <| hex "1ed760"
                        ]
                    , class SpeakerIcon
                        [ display inline
                        , color <| hex "1ed760"
                        ]
                    , class Icons
                        [ display block
                        , hover
                            [ children
                                [ class PauseIcon
                                    [ display inline
                                    , color <| hex "1ed760"
                                    ]
                                , class SpeakerIcon
                                    [ display none
                                    ]
                                ]
                            ]
                        ]
                    ]
                , hover
                    [ descendants
                        [ class PlayIcon
                            [ display none
                            ]
                        ]
                    ]
                ]
            ]
        , class SongNumber
            [ paddingRight <| px 15
            , color <| rgba 255 255 255 0.5
            ]
        , class SongInfo
            [ color <| rgba 255 255 255 0.5
            , display block
            , descendants
                [ span
                    [ (nthOfType "even")
                        [ before
                            [ property "content" "', '"
                            ]
                        ]
                    , lastChild
                        [ after
                            [ property "content" "'.'"
                            ]
                        ]
                    ]
                ]
            ]
        , each [ class SpeakerIcon, class PauseIcon, class PlayIcon ]
            [ display none
            , paddingRight <| px 15
            , cursor pointer
            ]
        , class Icons
            [ display none
            ]
        ]
