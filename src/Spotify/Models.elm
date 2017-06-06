module Spotify.Models exposing (..)

import Json.Encode as Encode
import Json.Decode as Decode
import Json.Decode.Pipeline exposing (required, decode, optional, hardcoded)

type alias User =
  { displayName : String
  , id : String
  , uri : String
  }

type alias NewPlaylist =
  { name : String
  , public : Bool
  , collaborative : Bool
  , description : String
  }

type alias Track =
  { id : String
  , name : String
  , preview_url : String
  , uri : String
  }

type alias Playlist =
  { description : String
  , id : String
  , name : String
  , owner : User
  , tracks : List Track
  }

type alias Snapshot =
  { id : String }

type alias URIs =
  { uris : List String }

userDecoder : Decode.Decoder User
userDecoder =
  decode User
    |> optional "display_name" Decode.string "You're Logged"
    |> required "id" Decode.string
    |> required "uri" Decode.string

newPlaylistEncoder : NewPlaylist -> Encode.Value
newPlaylistEncoder playlist =
  let
    attributes =
      [ ("name", Encode.string playlist.name)
      , ("public", Encode.bool playlist.public)
      , ("collaborative", Encode.bool playlist.collaborative)
      , ("description", Encode.string playlist.description)
      ]
  in
    Encode.object attributes

urisEncoder : URIs -> Encode.Value
urisEncoder uris =
  let
    attributes =
      [ ("uris", uris.uris |> List.map Encode.string |> Encode.list) ]
  in
    Encode.object attributes

playlistDecoder : Decode.Decoder Playlist
playlistDecoder =
  decode Playlist
    |> required "description" Decode.string
    |> required "id" Decode.string
    |> required "name" Decode.string
    |> required "owner" userDecoder
    |> hardcoded []

trackDecoder : Decode.Decoder Track
trackDecoder =
  decode Track
    |> required "id" Decode.string
    |> required "name" Decode.string
    |> optional "preview_url" Decode.string ""
    |> required "uri" Decode.string

snapshotDecoder : Decode.Decoder Snapshot
snapshotDecoder =
  decode Snapshot
    |> required "snapshot_id" Decode.string

grantTypeEncoder : String -> Encode.Value
grantTypeEncoder grantType =
  let
    attributes =
      [ ("grant_type", grantType |> Encode.string) ]
  in
    Encode.object attributes
