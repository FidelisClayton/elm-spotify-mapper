module Spotify.Update exposing (..)

import RemoteData

import Spotify.Models exposing (User, NewPlaylist)
import Spotify.Msgs exposing (SpotifyMsg)
import Spotify.Api exposing (createPlaylist, addTracks)
import Msgs exposing (Msg)
import Models exposing (Model)

updateSpotify : SpotifyMsg -> Model -> (Model, Cmd Msg)
updateSpotify msg model =
  case msg of
    Spotify.Msgs.FetchUserSuccess response ->
      case response of
        RemoteData.Success user ->
          ({ model | user = response }, Cmd.none )

        _ ->
          ({ model | user = response }, Cmd.none )

    Spotify.Msgs.CreatePlaylistSuccess response ->
      case response of
        RemoteData.Success playlist ->
          let
            oldPlaylist = model.playlist

            newPlaylist =
              { oldPlaylist
              | id = playlist.id
              , owner = playlist.owner
              , name = playlist.name
              }

            uris =
              { uris = List.map (\track -> track.uri) model.playlist.tracks }

            userId =
              newPlaylist.owner.id

            playlistId =
              newPlaylist.id

            token =
              case model.auth of
                Just auth ->
                  auth.accessToken

                Nothing ->
                  ""
          in
            ({ model | playlist = newPlaylist }, Cmd.map Msgs.MsgForSpotify (addTracks userId playlistId uris token))

        _ ->
          (model, Cmd.none)

    Spotify.Msgs.AddTracksSuccess response ->
      (model, Cmd.none)
