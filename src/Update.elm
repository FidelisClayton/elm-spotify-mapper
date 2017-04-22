module Update exposing (..)

import Msgs exposing (Msg)
import Models exposing (Model)
import Commands exposing (fetchArtist, fetchTopTracks)
import Ports exposing (playAudio, pauseAudio, provideTracks, nextTrack, previousTrack, updateCurrentTime, updateVolume)
import RemoteData
import Routing exposing (parseLocation)

import Helpers
import ModelHelpers

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Msgs.Search term ->
      let
        cmd =
          if String.length term > 1 then
            fetchArtist term
          else
            Cmd.none
      in
        ({ model | searchTerm = term } , cmd)

    Msgs.Play previewUrl ->
      ({ model | isPlaying = True}, playAudio previewUrl)

    Msgs.Pause ->
      ({ model | isPlaying = False }, pauseAudio "")

    Msgs.Stop value ->
      ({ model | isPlaying = False}, Cmd.none)

    Msgs.Next ->
      (model, nextTrack "")

    Msgs.Previous ->
      (model, previousTrack "")

    Msgs.ToggleSidebar ->
      ({ model | showMenu = not model.showMenu }, Cmd.none)

    Msgs.SearchArtistSuccess response ->
      ({ model | artists = response }, Cmd.none)

    Msgs.StartSearch ->
      ({ model | searching = True }, Cmd.none)

    Msgs.TopTracksSuccess response ->
      case response of
        RemoteData.Success tracks ->
          ({ model | topTracks = response}, provideTracks tracks)

        _ ->
          ({ model | topTracks = response}, Cmd.none)

    Msgs.SelectArtist artist ->
      ({ model
        | selectedArtist = Maybe.Just artist
        , route = Models.ExploreRoute
      }, fetchTopTracks artist.id)

    Msgs.SelectTrack track ->
      ({ model | selectedTrack = Maybe.Just track, isPlaying = True }, playAudio track.preview_url)

    Msgs.UpdateAudioStatus audioStatus ->
      ({ model | audioStatus = audioStatus}, Cmd.none)

    Msgs.UpdateCurrentTime time ->
      let
        currentTime = Helpers.pctToValue (Result.withDefault model.audioStatus.currentTime (String.toFloat time)) model.audioStatus.duration
      in
        ({ model
        | audioStatus = ModelHelpers.setAudioStatusTime currentTime model.audioStatus }
        , updateCurrentTime currentTime)

    Msgs.UpdateVolume volume ->
      let
        newVolume = (Result.withDefault model.audioStatus.volume (String.toFloat volume)) / 100
      in
        ({ model
        | audioStatus = ModelHelpers.setAudioStatusVolume newVolume model.audioStatus }
        , updateVolume newVolume)

    Msgs.OnLocationChange location ->
      let
        newRoute = parseLocation location
      in
        ({ model | route = newRoute }, Cmd.none)
