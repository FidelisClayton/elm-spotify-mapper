module Playlist.View.Playlist exposing (..)

import Html exposing (Html, text, div, span, i)
import Html.Attributes exposing (class)
import Msgs exposing (Msg)
import Models exposing (Model)
import List.Extra exposing (elemIndex)
import Playlist.View.Info exposing (playlistInfo)
import Spotify.Models exposing (Track)
import Playlist.Style exposing (Classes(Song, SongNumber, SongName, SongInfo, PlaylistPage, PlaylistSongs, SongPlaying, SpeakerIcon, PauseIcon, PlayIcon, Icons))
import Helpers exposing (cssClass)
import BottomBar.View.Player exposing (controlIcon)


formatArtists : List String -> Html Msg
formatArtists artists =
    span [ cssClass [ SongInfo ] ]
        (List.map
            (\artist -> span [] [ text artist ])
            artists
        )


song : Int -> Track -> Html Msg
song trackNumber track =
    div [ cssClass [ Song ] ]
        [ span [ cssClass [ SongNumber ] ] [ text <| toString (trackNumber) ++ "." ]
        , div
            [ cssClass [ Icons ] ]
            [ i [ cssClass [ SpeakerIcon ], class "fa fa-volume-up" ] []
            , i [ cssClass [ PauseIcon ], class "fa fa-pause" ] []
            , i [ cssClass [ PlayIcon ], class "fa fa-play" ] []
            ]
        , div []
            [ span [ cssClass [ SongName ] ] [ text track.name ]
            , formatArtists track.artists
            ]
        ]


playlist : Model -> Html Msg
playlist model =
    div [ cssClass [ PlaylistSongs ] ]
        (List.map
            (\track ->
                let
                    index =
                        case (elemIndex track model.playlist.tracks) of
                            Just value ->
                                value + 1

                            Nothing ->
                                0
                in
                    song index track
            )
            model.playlist.tracks
        )


render : Model -> List (Html Msg)
render model =
    [ div [ cssClass [ PlaylistPage ] ]
        [ playlistInfo model
        , playlist model
        ]
    ]
