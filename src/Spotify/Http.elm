module Spotify.Http exposing (..)

import Http exposing (request, header, expectJson, Request, Header)
import Json.Decode as Decode
import Base64

import Models exposing (SpotifyConfig)

resolveEncode : String -> String
resolveEncode string =
  case (Base64.encode string) of
    Ok s ->
      s
    Err err ->
      ""

defaultHeaders : String -> Header
defaultHeaders authToken =
  header "Authorization" ("Bearer " ++ authToken)

get : String -> Http.Body -> Decode.Decoder a -> String -> Request a
get url body decoder authToken =
  request
    { method = "GET"
    , headers = [ defaultHeaders authToken ]
    , body = body
    , expect = expectJson decoder
    , timeout = Nothing
    , withCredentials = False
    , url = url
    }

