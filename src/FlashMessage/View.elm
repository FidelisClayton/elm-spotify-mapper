module FlashMessage.View exposing (..)

import Html exposing (Html, div, text, span)
import Html.CssHelpers
import Html.Events exposing (onClick)

import Msgs exposing (Msg)
import Models exposing (Model)
import FlashMessage.Msgs as FlashMsg

import CssClasses

{ class } =
  Html.CssHelpers.withNamespace ""

render : Model -> Html Msg
render model =
  let
    classes =
      if model.flashMessage.active then
        [ CssClasses.FlashMessage ]
      else
        [ CssClasses.FlashMessage, CssClasses.Hidden ]
  in
    div [ class classes ]
        [ text model.flashMessage.message
        , span [ class [ CssClasses.CloseButton ], onClick (Msgs.MsgForFlashMessage  FlashMsg.Close) ]
            [ text "x" ]
        ]
