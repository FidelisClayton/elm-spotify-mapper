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
