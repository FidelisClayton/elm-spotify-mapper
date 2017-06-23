module Dialog.View.Form exposing (..)

import Css
import Dialog.Msgs as DialogMsg
import Dialog.Style as DialogStyle
import Helpers exposing (cssClass)
import Html exposing (Html, button, div, img, input, label, text, textarea)
import Html.Attributes exposing (for, rows, src, type_, value)
import Html.CssHelpers
import Html.Events exposing (on, onClick, onInput, targetValue)
import Json.Decode as Json
import Models exposing (Model)
import Msgs exposing (Msg)
import RemoteData


modalForm : Model -> Html Msg
modalForm model =
    div
        []
        [ div [ cssClass [ DialogStyle.InputGroup ] ]
            [ label [] [ text "Playlist name" ]
            , input
                [ cssClass [ DialogStyle.Input ]
                , type_ "text"
                , on "input" (Json.map (Msgs.MsgForDialog << DialogMsg.SetPlaylistName) targetValue)
                , value model.playlistInfo.name
                ]
                []
            ]
        , div [ cssClass [ DialogStyle.InputGroup ] ]
            [ label [] [ text "Playlist description" ]
            , textarea
                [ rows 7
                , on "input" (Json.map (Msgs.MsgForDialog << DialogMsg.SetPlaylistDescription) targetValue)
                , value model.playlistInfo.description
                ]
                []
            ]
        ]


modalFormFooter : Model -> Html Msg
modalFormFooter model =
    div [ cssClass [ DialogStyle.ModalFooter ] ]
        [ button
            [ cssClass [ DialogStyle.CancelButton ]
            , onClick (Msgs.MsgForDialog DialogMsg.Cancel)
            ]
            [ text "Cancel" ]
        , button
            [ cssClass [ DialogStyle.ConfirmButton ]
            , onClick (Msgs.MsgForDialog DialogMsg.Save)
            ]
            [ text "Confirm" ]
        ]
