module Spotify.Api exposing (..)

import RemoteData
import Http exposing (emptyBody, header, expectJson, jsonBody)
import Spotify.Http exposing (get, post, resolveEncode)
import Spotify.Msgs as Msgs exposing (SpotifyMsg)
import Spotify.Models as Models exposing (NewPlaylist, newPlaylistEncoder, playlistDecoder, snapshotDecoder, urisEncoder)

import Models exposing (authDataDecoder)

meEndpoint : String
meEndpoint =
  "https://api.spotify.com/v1/me"

getClientTokenEndpoint : String
getClientTokenEndpoint =
  "http://spotify-mapper.fidelisclayton.com/token"

createPlaylistEndpoint : String -> String
createPlaylistEndpoint userId =
  "https://api.spotify.com/v1/users/" ++ userId ++ "/playlists"

addTracksEndpoint : String -> String -> String
addTracksEndpoint userId playlistId =
  "https://api.spotify.com/v1/users/" ++ userId ++ "/playlists/" ++ playlistId ++ "/tracks"

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

addTracks : String -> String -> Models.URIs -> String -> Cmd SpotifyMsg
addTracks userId playlistId uris token =
  post (addTracksEndpoint userId playlistId) (urisEncoder uris) snapshotDecoder token
    |> RemoteData.sendRequest
    |> Cmd.map Msgs.AddTracksSuccess

getClientToken : String -> String -> Cmd SpotifyMsg
getClientToken clientId clientSecret =
  Http.get getClientTokenEndpoint authDataDecoder
    |> RemoteData.sendRequest
    |> Cmd.map Msgs.ClientTokenSuccess
