module Msgs exposing (..)

import Navigation exposing (Location)

import BottomBar.Msgs exposing (PlayerMsg)
import Explore.Msgs exposing (ExploreMsg)
import Search.Msgs exposing (SearchMsg)
import Sidebar.Msgs exposing (SidebarMsg)

type Msg
  = MsgForPlayer PlayerMsg
  | MsgForSidebar SidebarMsg
  | MsgForExplore ExploreMsg
  | MsgForSearch SearchMsg
  | OnLocationChange Location
