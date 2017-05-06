module Spotify.Models exposing (..)

import Json.Decode as Decode
import Json.Decode.Pipeline exposing (required, decode, optional)

type alias User =
  { displayName : String
  , id : String
  , uri : String
  }

userDecoder : Decode.Decoder User
userDecoder =
  decode User
    |> optional "display_name" Decode.string "You're Logged"
    |> required "id" Decode.string
    |> required "uri" Decode.string
