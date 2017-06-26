module Msgs exposing (..)

import BottomBar.Msgs exposing (PlayerMsg)
import Dialog.Msgs exposing (DialogMsg)
import Explore.Msgs exposing (ExploreMsg)
import FlashMessage.Msgs exposing (FlashMessageMsg)
import Models exposing (SpotifyAuthData)
import Navigation exposing (Location)
import Playlist.Msgs exposing (PlaylistMsg)
import Search.Msgs exposing (SearchMsg)
import Sidebar.Msgs exposing (SidebarMsg)
import Spotify.Msgs exposing (SpotifyMsg)
import Tutorial.Msgs exposing (TutorialMsg)


type Msg
    = MsgForPlayer PlayerMsg
    | MsgForSidebar SidebarMsg
    | MsgForExplore ExploreMsg
    | MsgForSearch SearchMsg
    | MsgForSpotify SpotifyMsg
    | MsgForFlashMessage FlashMessageMsg
    | MsgForTutorial TutorialMsg
    | MsgForDialog DialogMsg
    | MsgForPlaylist PlaylistMsg
    | OnLocationChange Location
    | UpdateAuthData (Maybe SpotifyAuthData)
