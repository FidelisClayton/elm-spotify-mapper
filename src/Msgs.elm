module Msgs exposing (..)

import Models exposing (Artist, SearchArtistData, TopTracks, Track, AudioStatus, RelatedArtists, VisNode, VisEdge)
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
  | RelatedArtistsSuccess (WebData RelatedArtists)
  | SelectArtist Artist
  | SelectTrack Track
  | UpdateAudioStatus AudioStatus
  | UpdateCurrentTime String
  | UpdateVolume String
  | OnLocationChange Location
  | OnVisNodeClick String
  | UpdateNetwork (List VisNode, List VisEdge)
