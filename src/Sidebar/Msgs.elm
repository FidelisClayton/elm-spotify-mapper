module Sidebar.Msgs exposing (..)

import Models exposing (TopTracks, Track)
import RemoteData exposing (WebData)


type SidebarMsg
    = ToggleSidebar
    | SelectTrack Track
    | TopTracksSuccess (WebData TopTracks)
