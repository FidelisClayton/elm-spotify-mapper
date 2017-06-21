module Search.Msgs exposing (..)

import Models exposing (Artist, SearchArtistData)
import RemoteData exposing (WebData)


type SearchMsg
    = StartSearch
    | Search String
    | SearchArtistSuccess (WebData SearchArtistData)
    | SelectArtist Artist
