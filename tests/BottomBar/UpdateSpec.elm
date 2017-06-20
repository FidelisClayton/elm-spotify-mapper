module BottomBar.UpdateSpec exposing (..)

import Expect exposing (..)
import Fuzz exposing (..)
import Test exposing (..)

import BottomBar.Update exposing (updatePlayer)
import Models exposing (Model,initialModel, Route(..), Flags, AudioStatus)
import BottomBar.Msgs as Player exposing (PlayerMsg)
import Msgs
import Ports

spotifyConfig : Models.SpotifyConfig
spotifyConfig =
  Models.SpotifyConfig "" "" ""

spotifyAuthData : Maybe Models.SpotifyAuthData
spotifyAuthData =
  Nothing

model : Model
model =
  initialModel SearchRoute (Flags spotifyConfig spotifyAuthData)

tests : Test
tests =
  describe "BottomBar.Update"
    [ describe "Player.Play"
      [ test "player should start to play" <|
        \_ ->
          let
            expected =
              ({ model | isPlaying = True }, Cmd.map Msgs.MsgForPlayer (Ports.playAudio "song.mp3"))
          in
            expected
              |> Expect.equal (updatePlayer (Player.Play "song.mp3") model)
      ]

    , describe "Player.Pause"
      [ test "player should pause" <|
        \_ ->
          let
            expected =
              ({ model | isPlaying = False }, Cmd.map Msgs.MsgForPlayer (Ports.pauseAudio ""))
          in
            expected
              |> Expect.equal (updatePlayer Player.Pause model)
      ]

    , describe "Player.Stop"
      [ test "player should stop" <|
        \_ ->
          let
            expected =
              ({ model | isPlaying = False }, Cmd.none)
          in
            expected
              |> Expect.equal (updatePlayer (Player.Stop "") model)
      ]

    , describe "Player.Next"
      [ test "player should go to the next song" <|
        \_ ->
          let
            expected =
              (model, Cmd.map Msgs.MsgForPlayer (Ports.nextTrack ""))
          in
            expected
              |> Expect.equal (updatePlayer Player.Next model)
      ]

    , describe "Player.Previous"
      [ test "player should go to the previous song" <|
        \_ ->
          let
            expected =
              (model, Cmd.map Msgs.MsgForPlayer (Ports.previousTrack ""))
          in
            expected
              |> Expect.equal (updatePlayer Player.Previous model)
      ]

    , describe "Player.UpdateAudioStatus"
      [ test "should update the audio status" <|
        \_ ->
          let
            audioStatus =
              AudioStatus 0 0 0

            expected =
              ({ model | audioStatus = audioStatus}, Cmd.none)
          in
            expected
              |> Expect.equal (updatePlayer (Player.UpdateAudioStatus audioStatus) model)
      ]

    , describe "Player.UpdateCurrentTime"
      [ test "should update the player current time" <|
        \_ ->
          let
            audioStatus =
              model.audioStatus
                |> (\a -> { a | currentTime = 30 })

            expected =
              ({ model | audioStatus = audioStatus }, Cmd.map Msgs.MsgForPlayer (Ports.updateCurrentTime 30))
          in
            expected
              |> Expect.equal (updatePlayer (Player.UpdateCurrentTime "100") model)
      ]

    , describe "Player.UpdateVolume"
      [ test "should update the player volume" <|
        \_ ->
          let
            audioStatus =
              model.audioStatus
                |> (\a -> { a | volume = 0.3})

            expected =
              ({ model | audioStatus = audioStatus }, Cmd.map Msgs.MsgForPlayer (Ports.updateVolume 0.3))
          in
            expected
              |> Expect.equal (updatePlayer (Player.UpdateVolume "30") model)
      ]
    ]
