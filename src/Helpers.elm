module Helpers exposing (..)

import Models exposing (ImageObject, Artist, VisNode, VisEdge)

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

getByIndex : Int -> List a -> Maybe a
getByIndex index items =
  List.take index items
    |> List.reverse
    |> List.head

getLastItem : List a -> Maybe a
getLastItem items =
  List.reverse items
    |> List.head

artistToNode : Artist -> VisNode
artistToNode artist =
  let
    image =
      case (getLastItem artist.images) of
        Just image ->
          image.url

        Nothing ->
          ""
  in
    { id = artist.id
    , label = artist.name
    , value = artist.popularity
    , shape = "circularImage"
    , image = image
    }

artistsToEdge : String -> List Artist -> List VisEdge
artistsToEdge fromId artists =
  List.map (\artist ->
    VisEdge fromId artist.id
  ) artists

filterNewArtists : List Artist -> List VisNode -> List Artist
filterNewArtists artists nodes =
  List.filter (\artist ->
    let
      repeatedNodes = List.filter (\node ->
        node.id == artist.id
      ) nodes
    in
      not ((List.length repeatedNodes) > 0)
  ) artists

filterArtistsWithRelated : String -> List Artist -> List Artist
filterArtistsWithRelated id artists =
  filterArtistById id artists
    |> List.filter (\artist -> artist.hasRelated)

filterArtistById : String -> List Artist -> List Artist
filterArtistById id artists =
  List.filter (\artist -> artist.id == id) artists
