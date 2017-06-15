module Dialog.Update exposing (..)

import RemoteData

import Models exposing (Model)
import Msgs exposing (Msg)
import Dialog.Msgs as Dialog exposing (DialogMsg)
import Spotify.Api exposing (addTracks, createPlaylist)
import Spotify.Models exposing (NewPlaylist)
import Helpers

updateDialog : DialogMsg -> Model -> (Model, Cmd Msg)
updateDialog msg model =
  case msg of
    Dialog.SetPlaylistName name ->
      let
        playlistInfo = model.playlistInfo
        newPlaylistInfo =
          { playlistInfo | name = name }

        newModel = { model | playlistInfo = newPlaylistInfo }
      in
        newModel ! []

    Dialog.SetPlaylistDescription description ->
      let
        playlistInfo = model.playlistInfo
        newPlaylistInfo =
          { playlistInfo | description = description }

        newModel = { model | playlistInfo = newPlaylistInfo }
      in
        newModel ! []

    Dialog.Cancel ->
      let
        newModel = { model | playlistModalActive = False }
      in
        newModel ! []

    Dialog.Save ->
      savePlaylist model

savePlaylist : Model -> (Model, Cmd Msg)
savePlaylist model =
  case model.user of
    RemoteData.Success user ->
      case model.auth of
        Just auth ->
          let
            playlist = NewPlaylist model.playlist.name False False model.playlist.description
            cmds =
              [ Cmd.map Msgs.MsgForSpotify (createPlaylist user.id playlist auth.accessToken) ]

            newModel = { model | playlistModalActive = True, playlistModalLoading = True }
          in
            newModel ! cmds

        Nothing ->
          model ! []
    _ ->
      model ! []
