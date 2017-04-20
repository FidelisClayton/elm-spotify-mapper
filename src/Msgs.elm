module Msgs exposing (..)

import Models exposing (Artist, ArtistsData, SearchArtistData)
import RemoteData exposing (WebData)

type Msg
  = Search
  | Play
  | Pause
  | ToggleSidebar
  | SearchArtistSuccess (WebData SearchArtistData)
