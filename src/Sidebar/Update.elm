module Sidebar.Update exposing (..)

import Models exposing (Model)
import Msgs exposing (Msg)
import Ports exposing (playAudio, provideTracks)
import Sidebar.Msgs as Sidebar exposing (SidebarMsg)
import Helpers

import RemoteData

updateSidebar : SidebarMsg -> Model -> (Model, Cmd Msg)
updateSidebar msg model =
  case msg of
    Sidebar.ToggleSidebar ->
      ({ model | showMenu = not model.showMenu }, Cmd.none)

    Sidebar.SelectTrack track ->
      ({ model | selectedTrack = Maybe.Just track, isPlaying = True }, playAudio track.preview_url)

    Sidebar.TopTracksSuccess response ->
      case response of
        RemoteData.Success tracks ->
          if model.waitingToPlay then
            case List.head tracks.tracks of
              Just track ->
                let
                  previousPlaylist = model.playlist

                  oldTracks = previousPlaylist.tracks

                  newTracks =
                    List.take 5 tracks.tracks
                      |> List.map Helpers.toSpotifyTrack
                      |> Helpers.filterNewTracks oldTracks

                  newPlaylist =
                    { previousPlaylist | tracks = List.append newTracks oldTracks }

                  newModel =
                    { model
                    | topTracks = response
                    , selectedTrack = Just track
                    , waitingToPlay = False
                    , playlist = newPlaylist
                    }
                in
                  (newModel, Cmd.batch [provideTracks tracks, playAudio track.preview_url])

              Nothing ->
                let
                  previousPlaylist = model.playlist

                  oldTracks = previousPlaylist.tracks

                  newTracks =
                    List.take 5 tracks.tracks
                      |> List.map Helpers.toSpotifyTrack
                      |> Helpers.filterNewTracks oldTracks

                  newPlaylist =
                    { previousPlaylist | tracks = List.append newTracks oldTracks}
                in
                  ({ model | topTracks = response, waitingToPlay = False, playlist = newPlaylist }, provideTracks tracks)
          else
            let
              previousPlaylist = model.playlist

              oldTracks = previousPlaylist.tracks

              newTracks =
                List.take 5 tracks.tracks
                  |> List.map Helpers.toSpotifyTrack
                  |> Helpers.filterNewTracks oldTracks

              newPlaylist =
                { previousPlaylist | tracks = List.append newTracks oldTracks}
            in
              ({ model | topTracks = response, playlist = newPlaylist }, provideTracks tracks)

        _ ->
          ({ model | topTracks = response}, Cmd.none)
