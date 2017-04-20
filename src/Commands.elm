module Commands exposing (..)

import Http
import RemoteData
import Json.Decode as Decode

import Models exposing (Artist, artistsDataDecoder, searchArtistDecoder)
import Msgs exposing (Msg)

fetchArtistUrl : String -> String
fetchArtistUrl artist =
  "https://api.spotify.com/v1/search?type=artist&q=" ++ artist

fetchArtist : String -> Cmd Msg
fetchArtist name =
  Http.get (fetchArtistUrl name) searchArtistDecoder
    |> RemoteData.sendRequest
    |> Cmd.map Msgs.SearchArtistSuccess
