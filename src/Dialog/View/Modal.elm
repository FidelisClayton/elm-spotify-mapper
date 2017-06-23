module Dialog.View.Modal exposing (..)

import Css
import Dialog.Msgs as DialogMsg
import Dialog.Style as DialogStyle
import Dialog.View.Form exposing (modalForm, modalFormFooter)
import Helpers exposing (cssClass)
import Html exposing (Html, button, div, img, input, label, text, textarea)
import Html.Attributes exposing (for, rows, src, type_, value)
import Html.CssHelpers
import Html.Events exposing (on, onClick, onInput, targetValue)
import Json.Decode as Json
import Models exposing (Model)
import Msgs exposing (Msg)
import RemoteData


modalLoading : Model -> Html Msg
modalLoading model =
    img
        [ cssClass [ DialogStyle.Spinner ]
        , src "http://shop.laurie.dk/Content/images/loading.gif"
        ]
        []


modal : Model -> String -> (Model -> Html Msg) -> Maybe (Model -> Html Msg) -> Html Msg
modal model title content footer =
    let
        wrapperClasses =
            if model.playlistModalActive then
                [ DialogStyle.ModalWrapper ]
            else
                [ DialogStyle.Hidden ]

        modalClasses =
            if model.playlistModalActive then
                [ DialogStyle.Modal ]
            else
                [ DialogStyle.Modal, DialogStyle.ModalHidden ]

        maybeFooter =
            case footer of
                Just view ->
                    [ view model ]

                Nothing ->
                    []
    in
    div
        [ cssClass wrapperClasses ]
        [ div [ cssClass modalClasses ]
            [ div [ cssClass [ DialogStyle.ModalHeader ] ] [ text title ]
            , div [ cssClass [ DialogStyle.ModalBody ] ]
                [ content model ]
            , div [ cssClass [ DialogStyle.ModalFooter ] ]
                maybeFooter
            ]
        , div [ cssClass [ DialogStyle.Mask ], onClick (Msgs.MsgForDialog DialogMsg.Cancel) ] []
        ]


render : Model -> Html Msg
render model =
    case model.playlistModalLoading of
        True ->
            modal model "Edit playlist info" modalLoading Nothing

        False ->
            modal model "Edit playlist info" modalForm (Just modalFormFooter)
