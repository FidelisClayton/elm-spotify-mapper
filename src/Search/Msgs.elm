module Search.Msgs exposing (..)

import RemoteData exposing (WebData)
import Models exposing (Artist, SearchArtistData)

type SearchMsg
  = StartSearch
  | Search String
  | SearchArtistSuccess (WebData SearchArtistData)
  | SelectArtist Artist
