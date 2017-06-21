module ModelHelpers exposing (..)

import Models exposing (AudioStatus, Model)
import Spotify.Models exposing (Playlist, Track, User)


setAudioStatusVolume : Float -> AudioStatus -> AudioStatus
setAudioStatusVolume volume audioStatus =
    { audioStatus | volume = volume }


setAudioStatusTime : Float -> AudioStatus -> AudioStatus
setAudioStatusTime time audioStatus =
    { audioStatus | currentTime = time }


updatePlaylistOwner : User -> Model -> Model
updatePlaylistOwner user model =
    let
        playlist =
            model.playlist

        newPlaylist =
            { playlist | owner = user }
    in
    { model | playlist = newPlaylist }


addTrackToPlaylist : Track -> Playlist -> Playlist
addTrackToPlaylist track playlist =
    let
        newTracks =
            track :: playlist.tracks
    in
    { playlist | tracks = newTracks }
