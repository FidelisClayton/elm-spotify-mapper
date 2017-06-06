module Spotify.Update exposing (..)

import RemoteData
import Http

import Spotify.Models exposing (User, NewPlaylist)
import Spotify.Msgs as Spotify exposing (SpotifyMsg)
import Spotify.Api exposing (createPlaylist, addTracks)
import Msgs exposing (Msg)
import Models exposing (Model)

import FlashMessage.Models as FlashMessage exposing (MessageType)

updateSpotify : SpotifyMsg -> Model -> (Model, Cmd Msg)
updateSpotify msg model =
  case msg of
    Spotify.FetchUserSuccess response ->
      case response of
        RemoteData.Success user ->
          ({ model | user = response }, Cmd.none )

        _ ->
          ({ model | user = response }, Cmd.none )

    Spotify.CreatePlaylistSuccess (RemoteData.Success playlist) ->
      onCreatePlaylistSuccess playlist model

    Spotify.CreatePlaylistSuccess (RemoteData.Failure error) ->
      onCreatePlaylistFailure error model

    Spotify.CreatePlaylistSuccess RemoteData.Loading ->
      model ! []

    Spotify.CreatePlaylistSuccess RemoteData.NotAsked ->
      model ! []

    Spotify.AddTracksSuccess response ->
      (model, Cmd.none)

    Spotify.ClientTokenSuccess (RemoteData.Success authData) ->
      { model | clientAuthData = authData } ! []

    Spotify.ClientTokenSuccess response ->
      case response of
        _ ->
          model ! []


onCreatePlaylistFailure : Http.Error -> Model -> (Model, Cmd Msg)
onCreatePlaylistFailure error model =
  let
    flashMessage =
      { active = True
      , messageType = FlashMessage.Danger
      , message = "An error has ocurred "
      }

    newModel =
      { model | flashMessage = flashMessage }
  in
    newModel ! []

onCreatePlaylistSuccess : Spotify.Models.Playlist -> Model -> (Model, Cmd Msg)
onCreatePlaylistSuccess playlist model =
  let
    oldPlaylist = model.playlist

    newPlaylist =
      { oldPlaylist
      | id = playlist.id
      , owner = playlist.owner
      , name = playlist.name
      }

    uris = { uris = List.map (\track -> track.uri) model.playlist.tracks }
    userId = newPlaylist.owner.id
    playlistId = newPlaylist.id

    token =
      case model.auth of
        Just auth ->
          auth.accessToken

        Nothing ->
          ""

    flashMessage = model.flashMessage
    newFlashMessage = { flashMessage | message = "Playlist successfully created!", active = True }

    newModel = { model | flashMessage = newFlashMessage, playlist = newPlaylist }
  in
    newModel ! [ Cmd.map Msgs.MsgForSpotify (addTracks userId playlistId uris token) ]
