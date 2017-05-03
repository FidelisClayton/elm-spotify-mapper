module Msgs exposing (..)

import Models exposing (Artist, SearchArtistData, TopTracks, Track, AudioStatus, RelatedArtists, VisNode, VisEdge)
import RemoteData exposing (WebData)
import Navigation exposing (Location)

type PlayerMsg
  = Play String
  | Pause
  | Stop String
  | Next
  | Previous
  | UpdateAudioStatus AudioStatus
  | UpdateCurrentTime String
  | UpdateVolume String

type SidebarMsg
  = ToggleSidebar
  | SelectTrack Track
  | TopTracksSuccess (WebData TopTracks)

type ExploreMsg
  = OnVisNodeClick String
  | UpdateNetwork (List VisNode, List VisEdge)
  | ArtistByIdSuccess (WebData Artist)
  | OnDoubleClick String
  | RelatedArtistsSuccess (WebData RelatedArtists)

type SearchMsg
  = StartSearch
  | Search String
  | SearchArtistSuccess (WebData SearchArtistData)
  | SelectArtist Artist

type Msg
  = MsgForPlayer PlayerMsg
  | MsgForSidebar SidebarMsg
  | MsgForExplore ExploreMsg
  | OnLocationChange Location
