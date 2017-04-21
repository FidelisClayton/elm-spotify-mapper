module Update exposing (..)

import Msgs exposing (Msg)
import Models exposing (Model)
import Commands exposing (fetchArtist)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Msgs.Search term ->
      let
        cmd =
          if String.length term > 1 then
            fetchArtist term
          else
            Cmd.none
      in
        ({ model | searchTerm = term } , cmd)

    Msgs.Play ->
      (model, Cmd.none)

    Msgs.Pause ->
      (model, Cmd.none)

    Msgs.ToggleSidebar ->
      ({ model | showMenu = not model.showMenu }, Cmd.none)

    Msgs.SearchArtistSuccess response ->
      ({ model | artists = response }, Cmd.none)

    Msgs.StartSearch ->
      ({ model | searching = True }, Cmd.none)
