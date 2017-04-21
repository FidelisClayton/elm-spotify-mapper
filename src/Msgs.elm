module Msgs exposing (..)

import Models exposing (Artist, SearchArtistData, TopTracks, Track)
import RemoteData exposing (WebData)

type Msg
  = Search String
  | Play
  | Pause
  | ToggleSidebar
  | StartSearch
  | SearchArtistSuccess (WebData SearchArtistData)
  | TopTracksSuccess (WebData TopTracks)
  | SelectArtist Artist
  | SelectTrack Track
