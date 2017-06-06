module Spotify.Msgs exposing (..)

import RemoteData exposing (WebData)
import Spotify.Models exposing (User, Playlist, Snapshot)
import Models exposing (SpotifyAuthData)

type SpotifyMsg
  = FetchUserSuccess (WebData User)
  | CreatePlaylistSuccess (WebData Playlist)
  | AddTracksSuccess (WebData Snapshot)
  | ClientTokenSuccess (WebData SpotifyAuthData)
