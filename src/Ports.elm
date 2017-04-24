port module Ports exposing (..)

import Models exposing (TopTracks, Track, AudioStatus, Artist)

port playAudio : String -> Cmd msg
port pauseAudio : String -> Cmd msg
port provideTracks : TopTracks -> Cmd msg
port nextTrack : String -> Cmd msg
port previousTrack : String -> Cmd msg
port updateCurrentTime : Float -> Cmd msg
port updateVolume : Float -> Cmd msg

port audioEnded : (String -> msg) -> Sub msg
port updateCurrentTrack : (Track -> msg) -> Sub msg
port updateAudioStatus : (AudioStatus -> msg) -> Sub msg

port initVis : Artist -> Cmd msg
port destroyVis : String -> Cmd msg

port getVisStatus : (Bool -> msg) -> Sub msg
