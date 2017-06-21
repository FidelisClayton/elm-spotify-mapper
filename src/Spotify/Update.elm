module Spotify.Update exposing (..)

import FlashMessage.Models as FlashMessage exposing (MessageType)
import Http
import Models exposing (Model)
import Msgs exposing (Msg)
import RemoteData
import Spotify.Api exposing (addTracks, createPlaylist)
import Spotify.Models exposing (NewPlaylist, User)
import Spotify.Msgs as Spotify exposing (SpotifyMsg)


updateSpotify : SpotifyMsg -> Model -> ( Model, Cmd Msg )
updateSpotify msg model =
    case msg of
        Spotify.FetchUserSuccess response ->
            case response of
                RemoteData.Success user ->
                    ( { model | user = response }, Cmd.none )

                _ ->
                    ( { model | user = response }, Cmd.none )

        Spotify.CreatePlaylistSuccess (RemoteData.Success playlist) ->
            onCreatePlaylistSuccess playlist model

        Spotify.CreatePlaylistSuccess (RemoteData.Failure error) ->
            onCreatePlaylistFailure error model

        Spotify.CreatePlaylistSuccess RemoteData.Loading ->
            { model | playlistModalLoading = True } ! []

        Spotify.CreatePlaylistSuccess RemoteData.NotAsked ->
            { model | playlistModalLoading = model.playlistModalLoading } ! []

        Spotify.AddTracksSuccess response ->
            case response of
                RemoteData.Loading ->
                    { model | playlistModalLoading = True } ! []

                RemoteData.NotAsked ->
                    { model | playlistModalLoading = model.playlistModalLoading } ! []

                _ ->
                    { model | playlistModalLoading = False, playlistModalActive = False } ! []

        Spotify.ClientTokenSuccess (RemoteData.Success authData) ->
            { model | clientAuthData = authData } ! []

        Spotify.ClientTokenSuccess response ->
            case response of
                _ ->
                    model ! []


onCreatePlaylistFailure : Http.Error -> Model -> ( Model, Cmd Msg )
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


onCreatePlaylistSuccess : Spotify.Models.Playlist -> Model -> ( Model, Cmd Msg )
onCreatePlaylistSuccess playlist model =
    let
        oldPlaylist =
            model.playlist

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

        flashMessage =
            model.flashMessage

        newFlashMessage =
            { flashMessage | message = "Playlist successfully created!", active = True }

        newModel =
            { model | flashMessage = newFlashMessage, playlist = newPlaylist }
    in
    newModel ! [ Cmd.map Msgs.MsgForSpotify (addTracks userId playlistId uris token) ]
