module Spotify.Api exposing (..)

import RemoteData
import Http exposing (emptyBody)
import Spotify.Http exposing (get)
import Spotify.Msgs as Msgs exposing (SpotifyMsg)
import Spotify.Models as Models

getMe : String -> Cmd SpotifyMsg
getMe token =
  get "https://api.spotify.com/v1/me" emptyBody Models.userDecoder token
    |> RemoteData.sendRequest
    |> Cmd.map Msgs.FetchUserSuccess
