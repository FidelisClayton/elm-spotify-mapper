module BottomBar.Update exposing (..)

import Models exposing (Model)
import Msgs exposing (Msg)
import BottomBar.Msgs as Player exposing (PlayerMsg)
import ModelHelpers
import Helpers

import Ports exposing (updateVolume, updateCurrentTime, nextTrack, playAudio, previousTrack, pauseAudio)

updatePlayer : PlayerMsg -> Model -> (Model, Cmd Msg)
updatePlayer msg model =
  case msg of
    Player.Play previewUrl ->
      ({ model | isPlaying = True }, Cmd.map Msgs.MsgForPlayer (playAudio previewUrl))

    Player.Pause ->
      ({ model | isPlaying = False }, Cmd.map Msgs.MsgForPlayer (pauseAudio ""))

    Player.Stop value ->
      ({ model | isPlaying = False}, Cmd.none)

    Player.Next ->
      (model, Cmd.map Msgs.MsgForPlayer (nextTrack ""))

    Player.Previous ->
      (model, Cmd.map Msgs.MsgForPlayer (previousTrack ""))

    Player.UpdateAudioStatus audioStatus ->
      ({ model | audioStatus = audioStatus}, Cmd.none)

    Player.UpdateCurrentTime time ->
      let
        currentTime =
          Helpers.pctToValue
            (Result.withDefault model.audioStatus.currentTime (String.toFloat time))
            model.audioStatus.duration
      in
        ({ model
        | audioStatus = ModelHelpers.setAudioStatusTime currentTime model.audioStatus }
        , Cmd.map Msgs.MsgForPlayer (updateCurrentTime currentTime))

    Player.UpdateVolume volume ->
      let
        newVolume = (Result.withDefault model.audioStatus.volume (String.toFloat volume)) / 100
      in
        ({ model
        | audioStatus = ModelHelpers.setAudioStatusVolume newVolume model.audioStatus }
        , Cmd.map Msgs.MsgForPlayer (updateVolume newVolume))
