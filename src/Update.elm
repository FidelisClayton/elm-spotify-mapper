module Update exposing (..)

import Msgs exposing (Msg)
import Models exposing (Model)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Msgs.Search ->
      (model, Cmd.none)

    Msgs.Play ->
      (model, Cmd.none)

    Msgs.Pause ->
      (model, Cmd.none)

    Msgs.ToggleSidebar ->
      ({ model | showMenu = not model.showMenu }, Cmd.none)
