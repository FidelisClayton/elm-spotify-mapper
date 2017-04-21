module Msgs exposing (..)

import Models exposing (Artist, ArtistsData, SearchArtistData)
import RemoteData exposing (WebData)
import Debounce exposing (Debounce)

type Msg
  = Search String
  | Play
  | Pause
  | ToggleSidebar
  | StartSearch
  | SearchArtistSuccess (WebData SearchArtistData)
