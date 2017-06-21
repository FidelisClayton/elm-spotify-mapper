module Spotify.Msgs exposing (..)

import Models exposing (SpotifyAuthData)
import RemoteData exposing (WebData)
import Spotify.Models exposing (Playlist, Snapshot, User)


type SpotifyMsg
    = FetchUserSuccess (WebData User)
    | CreatePlaylistSuccess (WebData Playlist)
    | AddTracksSuccess (WebData Snapshot)
    | ClientTokenSuccess (WebData SpotifyAuthData)
