module Spotify.Models exposing (..)

import Json.Encode as Encode
import Json.Decode as Decode
import Json.Decode.Pipeline exposing (required, decode, optional)

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
  }

type alias Playlist =
  { description : String
  , id : String
  , name : String
  -- , owner : User
  -- , tracks : List Track
  }

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

playlistDecoder : Decode.Decoder Playlist
playlistDecoder =
  decode Playlist
    |> required "description" Decode.string
    |> required "id" Decode.string
    |> required "name" Decode.string
    -- |> required "owner" Decode.string
