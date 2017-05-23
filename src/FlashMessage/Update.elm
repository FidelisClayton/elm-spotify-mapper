module FlashMessage.Update exposing (..)

import Models exposing (Model)
import Msgs exposing (Msg)
import FlashMessage.Msgs as FlashMessage exposing (FlashMessageMsg)

updateFlashMessage : FlashMessageMsg -> Model -> (Model, Cmd Msg)
updateFlashMessage msg model =
  case msg of
    FlashMessage.Close ->
      let
        flashMessage = model.flashMessage
        newFlashMessage = { flashMessage | active = False }
        newModel = { model | flashMessage = newFlashMessage }
      in
        newModel ! []
