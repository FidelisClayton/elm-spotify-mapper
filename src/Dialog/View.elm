module Dialog.View exposing (..)

import Html exposing (Html, div, text, label, input, textarea, button)
import Html.Attributes exposing (type_, for, rows)
import Html.CssHelpers
import Css

import Msgs exposing (Msg)
import Dialog.Style as DialogStyle

{ class } =
  Html.CssHelpers.withNamespace ""

styles : List Css.Mixin -> Html.Attribute msg
styles =
  Css.asPairs >> Html.Attributes.style

render : Html Msg
render =
  div [ class [ DialogStyle.Modal ] ]
    [ div [ class [ DialogStyle.ModalHeader ] ] [ text "Edit Playlist Details"]
    , div [ class [ DialogStyle.ModalBody ] ]
        [ div [ class [ DialogStyle.InputGroup ] ]
            [ label [] [ text "Playlist name" ]
            , input [ class [ DialogStyle.Input ], type_ "text" ] []
            ]
        , div [ class [ DialogStyle.InputGroup ] ]
            [ label [] [ text "Playlist description" ]
            , textarea [ rows 7 ] []
            ]
        ]
    , div [ class [ DialogStyle.ModalFooter ] ]
        [ button [ class [ DialogStyle.CancelButton ] ] [ text "Cancel" ]
        , button [ class [ DialogStyle.ConfirmButton ] ] [ text "Confirm" ]
        ]
    ]
