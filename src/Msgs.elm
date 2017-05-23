module Msgs exposing (..)

import Navigation exposing (Location)
import Models exposing (SpotifyAuthData)

import BottomBar.Msgs exposing (PlayerMsg)
import Explore.Msgs exposing (ExploreMsg)
import Search.Msgs exposing (SearchMsg)
import Sidebar.Msgs exposing (SidebarMsg)
import Spotify.Msgs exposing (SpotifyMsg)
import FlashMessage.Msgs exposing (FlashMessageMsg)

type Msg
  = MsgForPlayer PlayerMsg
  | MsgForSidebar SidebarMsg
  | MsgForExplore ExploreMsg
  | MsgForSearch SearchMsg
  | MsgForSpotify SpotifyMsg
  | MsgForFlashMessage FlashMessageMsg
  | OnLocationChange Location
  | UpdateAuthData (Maybe SpotifyAuthData)
