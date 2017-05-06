module Spotify.Msgs exposing (..)

import RemoteData exposing (WebData)
import Spotify.Models exposing (User)

type SpotifyMsg
  = FetchUserSuccess (WebData User)
