module FlashMessage.View exposing (..)

import Html exposing (Html, div, text, span)
import Html.CssHelpers

import Msgs exposing (Msg)
import Models exposing (Model)

import CssClasses

{ class } =
  Html.CssHelpers.withNamespace ""

render : Model -> Html Msg
render model =
  if model.flashMessage.active then
    div [ class [ CssClasses.FlashMessage ] ]
        [ text "Flash Message"
        , span [ class [ CssClasses.CloseButton ] ]
            [ text "x" ]
        ]
  else
    text ""
