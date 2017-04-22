module ModelHelpers exposing (..)

import Models exposing (AudioStatus)

setAudioStatusVolume : Float -> AudioStatus -> AudioStatus
setAudioStatusVolume volume audioStatus =
  { audioStatus | volume = volume }

setAudioStatusTime : Float -> AudioStatus -> AudioStatus
setAudioStatusTime time audioStatus =
  { audioStatus | currentTime = time }
