module Spotify.Msgs exposing (..)

import RemoteData exposing (WebData)
import Spotify.Models exposing (User, Playlist)

type SpotifyMsg
  = FetchUserSuccess (WebData User)
  | CreatePlaylistSuccess (WebData Playlist)
