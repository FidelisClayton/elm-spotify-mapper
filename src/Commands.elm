module Commands exposing (..)

import Http
import RemoteData
import Json.Decode as Decode

import Models exposing (Artist, searchArtistDecoder, topTracksDecoder)
import Msgs exposing (Msg)

fetchArtistUrl : String -> String
fetchArtistUrl artist =
  "https://api.spotify.com/v1/search?type=artist&limit=10&q=" ++ artist

topTracksUrl : String -> String
topTracksUrl artistId =
  "https://api.spotify.com/v1/artists/" ++ artistId ++ "/top-tracks?country=BR"

fetchArtist : String -> Cmd Msg
fetchArtist name =
  Http.get (fetchArtistUrl name) searchArtistDecoder
    |> RemoteData.sendRequest
    |> Cmd.map Msgs.SearchArtistSuccess

fetchTopTracks : String -> Cmd Msg
fetchTopTracks artistId =
  Http.get (topTracksUrl artistId) topTracksDecoder
    |> RemoteData.sendRequest
    |> Cmd.map Msgs.TopTracksSuccess
