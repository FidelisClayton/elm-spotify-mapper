module Playlist.Update exposing (..)

import List.Extra exposing (dropWhile)
import Models exposing (Model)
import Msgs exposing (Msg)
import Playlist.Msgs as Playlist exposing (PlaylistMsg)


updatePlaylist : PlaylistMsg -> Model -> ( Model, Cmd Msg )
updatePlaylist msg model =
    case msg of
        Playlist.RemoveTrack trackId ->
            let
                newTracks =
                    List.filter (\track -> track.id /= trackId) model.playlist.tracks

                newPlaylist =
                    model.playlist
                        |> (\playlist -> { playlist | tracks = newTracks })
            in
            { model | playlist = newPlaylist } ! []
