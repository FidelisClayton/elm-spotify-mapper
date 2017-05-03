module Sidebar.Msgs exposing (..)

import RemoteData exposing (WebData)
import Models exposing (TopTracks, Track)

type SidebarMsg
  = ToggleSidebar
  | SelectTrack Track
  | TopTracksSuccess (WebData TopTracks)
