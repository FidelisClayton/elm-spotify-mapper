module BottomBar.Msgs exposing (..)

import Models exposing (AudioStatus)

type PlayerMsg
  = Play String
  | Pause
  | Stop String
  | Next
  | Previous
  | UpdateAudioStatus AudioStatus
  | UpdateCurrentTime String
  | UpdateVolume String
