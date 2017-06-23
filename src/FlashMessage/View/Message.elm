module FlashMessage.View.Message exposing (..)

import CssClasses
import FlashMessage.Msgs as FlashMsg
import Html exposing (Html, div, span, text)
import Html.CssHelpers
import Html.Events exposing (onClick)
import Models exposing (Model)
import Msgs exposing (Msg)


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
        , span [ class [ CssClasses.CloseButton ], onClick (Msgs.MsgForFlashMessage FlashMsg.Close) ]
            [ text "x" ]
        ]
