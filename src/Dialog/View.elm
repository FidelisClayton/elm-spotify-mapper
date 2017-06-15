module Dialog.View exposing (..)

import Html exposing (Html, div, text, label, input, textarea, button)
import Html.Attributes exposing (type_, for, rows, value)
import Html.Events exposing (onInput, targetValue, on, onClick)
import Html.CssHelpers
import Css
import Json.Decode as Json

import Msgs exposing (Msg)
import Models exposing (Model)
import Dialog.Msgs as DialogMsg
import Dialog.Style as DialogStyle

{ class } =
  Html.CssHelpers.withNamespace ""

styles : List Css.Mixin -> Html.Attribute msg
styles =
  Css.asPairs >> Html.Attributes.style

render : Model -> Html Msg
render model =
  let
    modalClasses =
      if model.playlistModalActive then
        [ DialogStyle.Modal ]
      else
        [ DialogStyle.Modal, DialogStyle.ModalHidden ]
        -- [ DialogStyle.Modal ]
  in
    div [ class modalClasses ]
      [ div [ class [ DialogStyle.ModalHeader ] ] [ text "Edit Playlist Details"]
      , div [ class [ DialogStyle.ModalBody ] ]
          [ div [ class [ DialogStyle.InputGroup ] ]
              [ label [] [ text "Playlist name" ]
              , input
                  [ class [ DialogStyle.Input ]
                  , type_ "text"
                  , on "input" (Json.map (Msgs.MsgForDialog << DialogMsg.SetPlaylistName) targetValue)
                  , value model.playlist.name
                  ]
                  []
              ]
          , div [ class [ DialogStyle.InputGroup ] ]
              [ label [] [ text "Playlist description" ]
              , textarea
                  [ rows 7
                  , on "input" (Json.map (Msgs.MsgForDialog << DialogMsg.SetPlaylistDescription) targetValue)
                  , value model.playlist.name
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
