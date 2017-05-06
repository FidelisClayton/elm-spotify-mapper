module Spotify.Api exposing (..)

import RemoteData
import Spotify.Http exposing (get, post)
import Spotify.Msgs as Msgs exposing (SpotifyMsg)
import Spotify.Models as Models exposing (NewPlaylist, newPlaylistEncoder, playlistDecoder)

meEndpoint : String
meEndpoint =
  "https://api.spotify.com/v1/me"

createPlaylistEndpoint : String -> String
createPlaylistEndpoint userId =
  "https://api.spotify.com/v1/users/" ++ userId ++ "/playlists"

getMe : String -> Cmd SpotifyMsg
getMe token =
  get meEndpoint Models.userDecoder token
    |> RemoteData.sendRequest
    |> Cmd.map Msgs.FetchUserSuccess

createPlaylist : String -> NewPlaylist -> String -> Cmd SpotifyMsg
createPlaylist userId playlist token =
  post (createPlaylistEndpoint userId) (newPlaylistEncoder playlist) playlistDecoder token
    |> RemoteData.sendRequest
    |> Cmd.map Msgs.CreatePlaylistSuccess
