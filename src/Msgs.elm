module Msgs exposing (..)

import Navigation exposing (Location)
import Models exposing (SpotifyAuthData)

import BottomBar.Msgs exposing (PlayerMsg)
import Explore.Msgs exposing (ExploreMsg)
import Search.Msgs exposing (SearchMsg)
import Sidebar.Msgs exposing (SidebarMsg)
import Spotify.Msgs exposing (SpotifyMsg)

type Msg
  = MsgForPlayer PlayerMsg
  | MsgForSidebar SidebarMsg
  | MsgForExplore ExploreMsg
  | MsgForSearch SearchMsg
  | MsgForSpotify SpotifyMsg
  | OnLocationChange Location
  | UpdateAuthData (Maybe SpotifyAuthData)
