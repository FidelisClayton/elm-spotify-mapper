module FlashMessage.Update exposing (..)

import FlashMessage.Msgs as FlashMessage exposing (FlashMessageMsg)
import Models exposing (Model)
import Msgs exposing (Msg)


updateFlashMessage : FlashMessageMsg -> Model -> ( Model, Cmd Msg )
updateFlashMessage msg model =
    case msg of
        FlashMessage.Close ->
            let
                flashMessage =
                    model.flashMessage

                newFlashMessage =
                    { flashMessage | active = False }

                newModel =
                    { model | flashMessage = newFlashMessage }
            in
            newModel ! []

        FlashMessage.Show message ->
            let
                flashMessage =
                    model.flashMessage

                newFlashMessage =
                    { flashMessage | active = True, message = message }

                newModel =
                    { model | flashMessage = flashMessage }
            in
            newModel ! []
