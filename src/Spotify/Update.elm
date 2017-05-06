module Spotify.Update exposing (..)

import Spotify.Models exposing (User)
import Spotify.Msgs exposing (SpotifyMsg)
import Msgs exposing (Msg)
import Models exposing (Model)

updateSpotify : SpotifyMsg -> Model -> (Model, Cmd Msg)
updateSpotify msg model =
  case msg of
    Spotify.Msgs.FetchUserSuccess response ->
      ({ model | user = response }, Cmd.none )
