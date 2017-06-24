module Playlist.View.Playlist exposing (..)

import Html exposing (Html, text, div, span, i)
import Html.Attributes exposing (class)
import Msgs exposing (Msg)
import Models exposing (Model)
import Playlist.View.Info exposing (playlistInfo)
import Spotify.Models exposing (Track)
import Playlist.Style exposing (Classes(Song, SongNumber, SongName, SongDescription, PlaylistPage, PlaylistSongs, SongPlaying, SpeakerIcon, PauseIcon, PlayIcon, Icons))
import Helpers exposing (cssClass)
import BottomBar.View.Player exposing (controlIcon)


song : Html Msg
song =
    div [ cssClass [ Song ] ]
        [ span [ cssClass [ SongNumber ] ] [ text "1." ]
        , div
            [ cssClass [ Icons ] ]
            [ i [ cssClass [ SpeakerIcon ], class "fa fa-volume-up" ] []
            , i [ cssClass [ PauseIcon ], class "fa fa-pause" ] []
            , i [ cssClass [ PlayIcon ], class "fa fa-play" ] []
            ]
        , div []
            [ span [ cssClass [ SongName ] ] [ text "Sua assinatura" ]
            , span [ cssClass [ SongDescription ] ] [ text "Matanza" ]
            ]
        ]


song2 : Html Msg
song2 =
    div [ cssClass [ Song, SongPlaying ] ]
        [ span [ cssClass [ SongNumber ] ] [ text "1." ]
        , div
            [ cssClass [ Icons ] ]
            [ i [ cssClass [ SpeakerIcon ], class "fa fa-volume-up" ] []
            , i [ cssClass [ PauseIcon ], class "fa fa-pause" ] []
            , i [ cssClass [ PlayIcon ], class "fa fa-play" ] []
            ]
        , div []
            [ span [ cssClass [ SongName ] ] [ text "Sua assinatura" ]
            , span [ cssClass [ SongDescription ] ] [ text "Matanza" ]
            ]
        ]


playlist : Model -> Html Msg
playlist model =
    div [ cssClass [ PlaylistSongs ] ]
        [ song
        , song2
        , song
        ]


render : Model -> List (Html Msg)
render model =
    [ div [ cssClass [ PlaylistPage ] ]
        [ playlistInfo model
        , playlist model
        ]
    ]
