module Dialog.View exposing (..)

import Html exposing (Html, div, text, label, input, textarea, button, img)
import Html.Attributes exposing (type_, for, rows, value, src)
import Html.Events exposing (onInput, targetValue, on, onClick)
import Html.CssHelpers
import Css
import Json.Decode as Json
import RemoteData

import Msgs exposing (Msg)
import Models exposing (Model)
import Dialog.Msgs as DialogMsg
import Dialog.Style as DialogStyle

{ class } =
  Html.CssHelpers.withNamespace ""

styles : List Css.Mixin -> Html.Attribute msg
styles =
  Css.asPairs >> Html.Attributes.style

modalForm : Model -> Html Msg
modalForm model =
  let
    wrapperClasses =
      if model.playlistModalActive then
        [ DialogStyle.ModalWrapper ]
      else
        []

    modalClasses =
      if model.playlistModalActive then
        [ DialogStyle.Modal ]
      else
        [ DialogStyle.Modal, DialogStyle.ModalHidden ]
  in
    div
      [ class wrapperClasses ]
      [ div [ class modalClasses ]
        [ div [ class [ DialogStyle.ModalHeader ] ] [ text "Edit playlist info" ]
        , div [ class [ DialogStyle.ModalBody ] ]
            [ div [ class [ DialogStyle.InputGroup ] ]
                [ label [] [ text "Playlist name" ]
                , input
                    [ class [ DialogStyle.Input ]
                    , type_ "text"
                    , on "input" (Json.map (Msgs.MsgForDialog << DialogMsg.SetPlaylistName) targetValue)
                    , value model.playlistInfo.name
                    ]
                    []
                ]
            , div [ class [ DialogStyle.InputGroup ] ]
                [ label [] [ text "Playlist description" ]
                , textarea
                    [ rows 7
                    , on "input" (Json.map (Msgs.MsgForDialog << DialogMsg.SetPlaylistDescription) targetValue)
                    , value model.playlistInfo.description
                    ]
                    []
                ]
            ]
        , div [ class [ DialogStyle.ModalFooter ] ]
            [ button
                [ class [ DialogStyle.CancelButton ]
                , onClick (Msgs.MsgForDialog DialogMsg.Cancel)
                ]
                [ text "Cancel" ]
            , button
                [ class [ DialogStyle.ConfirmButton ]
                , onClick (Msgs.MsgForDialog DialogMsg.Save)
                ]
                [ text "Confirm" ]
            ]
        ]
      , div [ class [ DialogStyle.Mask ], onClick (Msgs.MsgForDialog DialogMsg.Cancel) ] []
      ]

modalLoading : Model -> Html Msg
modalLoading model =
  let
    wrapperClasses =
      if model.playlistModalActive then
        [ DialogStyle.ModalWrapper ]
      else
        []

    modalClasses =
      if model.playlistModalActive then
        [ DialogStyle.Modal ]
      else
        [ DialogStyle.Modal, DialogStyle.ModalHidden ]
  in
    div
      [ class wrapperClasses ]
      [ div [ class modalClasses ]
        [ div [ class [ DialogStyle.ModalHeader ] ] [ text "Edit playlist info" ]
        , div [ class [ DialogStyle.ModalBody ] ]
            [ img
                [ class [ DialogStyle.Spinner ]
                , src "http://shop.laurie.dk/Content/images/loading.gif" ]
                []
            ]
        ]
      , div [ class [ DialogStyle.Mask ], onClick (Msgs.MsgForDialog DialogMsg.Cancel) ] []
      ]

render : Model -> Html Msg
render model =
  case model.playlistModalLoading of
    True ->
      modalLoading model

    False ->
      modalForm model
