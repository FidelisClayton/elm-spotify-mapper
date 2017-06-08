port module Ports exposing (..)

import Models exposing (TopTracks, Track, AudioStatus, Artist, VisNetwork, VisNode, VisEdge, SpotifyAuthData)
import Tutorial.Msgs exposing (Step)

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

port initVis : VisNetwork -> Cmd msg
port destroyVis : String -> Cmd msg
port addSimilar : (List VisNode, List VisEdge) -> Cmd msg

port getVisStatus : (Bool -> msg) -> Sub msg
port onNodeClick : (String -> msg) -> Sub msg
port onDoubleClick : (String -> msg) -> Sub msg
port updateNetwork : ((List VisNode, List VisEdge) -> msg) -> Sub msg

port fromStorage : (Maybe SpotifyAuthData -> msg) -> Sub msg

port initTutorial : (List Step) -> Cmd msg
port addSteps : (List Step) -> Cmd msg
port nextStep : String -> Cmd msg
