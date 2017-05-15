module Spotify.Update exposing (..)

import RemoteData

import Spotify.Models exposing (User, NewPlaylist)
import Spotify.Msgs exposing (SpotifyMsg)
import Spotify.Api exposing (createPlaylist)
import Msgs exposing (Msg)
import Models exposing (Model)

updateSpotify : SpotifyMsg -> Model -> (Model, Cmd Msg)
updateSpotify msg model =
  case msg of
    Spotify.Msgs.FetchUserSuccess response ->
      case response of
        RemoteData.Success user ->
          case model.auth of
            Just auth ->
              let
                playlist = NewPlaylist "salkdj" False False "Testando"
              in
                -- ({ model | user = response }, Cmd.map Msgs.MsgForSpotify (createPlaylist user.id playlist auth.accessToken)) 
                ({ model | user = response }, Cmd.map Msgs.MsgForSpotify (createPlaylist user.id playlist auth.accessToken)) 
            Nothing ->
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
          in
            ({ model | playlist = newPlaylist }, Cmd.none)

        _ ->
          (model, Cmd.none)

    Spotify.Msgs.AddTracksSuccess response ->
      (model, Cmd.none)
