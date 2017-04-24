module Msgs exposing (..)

import Models exposing (Artist, SearchArtistData, TopTracks, Track, AudioStatus)
import RemoteData exposing (WebData)
import Navigation exposing (Location)

type Msg
  = Search String
  | Play String
  | Pause
  | Stop String
  | Next
  | Previous
  | ToggleSidebar
  | StartSearch
  | SearchArtistSuccess (WebData SearchArtistData)
  | TopTracksSuccess (WebData TopTracks)
  | SelectArtist Artist
  | SelectTrack Track
  | UpdateAudioStatus AudioStatus
  | UpdateCurrentTime String
  | UpdateVolume String
  | OnLocationChange Location
  | GetVisStatus Bool
