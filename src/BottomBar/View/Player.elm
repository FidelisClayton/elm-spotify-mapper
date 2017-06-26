module BottomBar.View.Player exposing (..)

import BottomBar.Msgs as Player exposing (PlayerMsg)
import BottomBar.Style exposing (Classes(..))
import Css exposing (property)
import Helpers exposing (cssClass, cssStyles)
import Html exposing (Html, div, i, img, input, span, text)
import Html.Attributes exposing (src, step, type_, value)
import Html.CssHelpers
import Html.Events exposing (on, onClick, onInput, targetValue)
import Json.Decode as Json
import Models exposing (Artist, Model, SearchArtistData, Track)
import Msgs exposing (Msg)
import RemoteData


controlIcon : String -> Html Msg
controlIcon icon =
    div [ cssClass [ ControlIcon ] ]
        [ i [ cssClass [ Icon ], Html.Attributes.class ("fa fa-" ++ icon) ] [] ]


progressBar : Float -> (String -> Player.PlayerMsg) -> Html Msg
progressBar progress msg =
    div [ cssClass [ ProgressBar ] ]
        [ div
            [ cssClass [ Progress ]
            , cssStyles
                [ property "width" (toString (floor progress) ++ "%") ]
            ]
            []
        , input
            [ type_ "range"
            , cssClass []
            , Html.Attributes.max "100"
            , Html.Attributes.min "0"
            , step "1"
            , on "input" (Json.map (Msgs.MsgForPlayer << msg) targetValue)
            , value <| toString <| floor progress
            ]
            []
        ]


progress : Model -> Html Msg
progress model =
    div [ cssClass [ ProgressGroup ] ]
        [ span [ cssClass [ FontSmall ] ]
            [ text <| "00:" ++ Helpers.paddValue model.audioStatus.currentTime ]
        , progressBar (Helpers.getPct model.audioStatus.currentTime model.audioStatus.duration) Player.UpdateCurrentTime
        , span [ cssClass [ FontSmall ] ]
            [ text <| "00:" ++ Helpers.paddValue model.audioStatus.duration ]
        ]


musicInfo : Maybe Track -> Html Msg
musicInfo selectedTrack =
    let
        content =
            case selectedTrack of
                Just track ->
                    [ img
                        [ src <| Helpers.firstImageUrl track.album.images
                        , cssClass [ AlbumCover ]
                        ]
                        []
                    , div [ cssClass [ MusicInfo ] ]
                        [ span [ cssClass [ MusicTitle ] ]
                            [ text track.name ]
                        , span [ cssClass [ FontSmall ] ]
                            [ text <| Helpers.firstArtistName track.artists ]
                        ]
                    ]

                Nothing ->
                    []
    in
    div [ cssClass [ NowPlaying ] ]
        content


soundControl : Model -> Html Msg
soundControl model =
    let
        icon =
            if model.audioStatus.volume > 0.6 then
                controlIcon "volume-up"
            else if model.audioStatus.volume > 0 then
                controlIcon "volume-down"
            else
                controlIcon "volume-off"
    in
    div [ cssClass [ SoundControl ] ]
        [ div [ cssClass [ ControlButtons ] ]
            [ icon ]
        , progressBar (model.audioStatus.volume * 100) Player.UpdateVolume
        ]


controls : Model -> Html Msg
controls model =
    let
        preview =
            case model.selectedTrack of
                Just track ->
                    track.preview_url

                Nothing ->
                    ""

        playOrPause =
            if model.isPlaying then
                div [ onClick (Msgs.MsgForPlayer Player.Pause) ] [ controlIcon "pause" ]
            else
                div [ onClick (Msgs.MsgForPlayer (Player.Play preview)) ] [ controlIcon "play" ]
    in
    div [ cssClass [ Controls ] ]
        [ div [ cssClass [ ControlButtons ] ]
            [ div [ onClick (Msgs.MsgForPlayer Player.Previous) ] [ controlIcon "step-backward" ]
            , playOrPause
            , div [ onClick (Msgs.MsgForPlayer Player.Next) ] [ controlIcon "step-forward" ]
            ]
        , progress model
        ]


maybeArtists : RemoteData.WebData SearchArtistData -> Html Msg
maybeArtists response =
    case response of
        RemoteData.NotAsked ->
            text "Not Asked"

        RemoteData.Loading ->
            text "Loading..."

        RemoteData.Success data ->
            text <| toString data

        RemoteData.Failure error ->
            text (toString "Error")


render : Model -> Html Msg
render model =
    div [ cssClass [ BottomBar ] ]
        [ musicInfo model.selectedTrack
        , controls model
        , soundControl model
        ]
