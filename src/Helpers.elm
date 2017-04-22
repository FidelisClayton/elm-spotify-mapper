module Helpers exposing (..)

import Models exposing (ImageObject, Artist)

firstImageUrl : List ImageObject -> String
firstImageUrl images =
  case List.head images of
    Just image ->
      image.url

    Nothing ->
      ""

firstArtistName : List Artist -> String
firstArtistName artists =
  case List.head artists of
    Just artist ->
      artist.name

    Nothing ->
      ""

paddValue : Float -> String
paddValue value =
  if value < 10 then
    "0" ++ (toString value)
  else
    toString value

getPct : Float -> Float -> Float
getPct current max =
  (current * 100) / max

pctToValue : Float -> Float -> Float
pctToValue current max =
  (current * max) / 100
