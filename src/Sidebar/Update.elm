module Sidebar.Update exposing (..)

import Models exposing (Model)
import Msgs exposing (Msg)
import Ports exposing (playAudio, provideTracks)
import Sidebar.Msgs as Sidebar exposing (SidebarMsg)

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
                  newModel =
                    { model
                    | topTracks = response
                    , selectedTrack = Just track
                    , waitingToPlay = False
                    }
                in
                  (newModel, Cmd.batch [provideTracks tracks, playAudio track.preview_url])

              Nothing ->
                ({ model | topTracks = response, waitingToPlay = False }, provideTracks tracks)
          else
            ({ model | topTracks = response}, provideTracks tracks)

        _ ->
          ({ model | topTracks = response}, Cmd.none)
