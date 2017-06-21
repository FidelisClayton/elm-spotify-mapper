module Commands exposing (..)

import Explore.Msgs as Explore exposing (ExploreMsg)
import Models exposing (Artist, artistDecoder, relatedArtistsDecoder, searchArtistDecoder, topTracksDecoder)
import RemoteData
import Search.Msgs as Search exposing (SearchMsg)
import Sidebar.Msgs as Sidebar exposing (SidebarMsg)
import Spotify.Http exposing (get)


fetchArtistUrl : String -> String
fetchArtistUrl artist =
    "https://api.spotify.com/v1/search?type=artist&limit=10&q=" ++ artist


fetchTopTracksUrl : String -> String
fetchTopTracksUrl artistId =
    "https://api.spotify.com/v1/artists/" ++ artistId ++ "/top-tracks?country=US"


fetchRelatedArtistsUrl : String -> String
fetchRelatedArtistsUrl artistId =
    "https://api.spotify.com/v1/artists/" ++ artistId ++ "/related-artists"


fetchArtistByIdUrl : String -> String
fetchArtistByIdUrl artistId =
    "https://api.spotify.com/v1/artists/" ++ artistId


fetchArtist : String -> String -> Cmd SearchMsg
fetchArtist name token =
    get (fetchArtistUrl name) searchArtistDecoder token
        |> RemoteData.sendRequest
        |> Cmd.map Search.SearchArtistSuccess


fetchTopTracks : String -> String -> Cmd SidebarMsg
fetchTopTracks artistId token =
    get (fetchTopTracksUrl artistId) topTracksDecoder token
        |> RemoteData.sendRequest
        |> Cmd.map Sidebar.TopTracksSuccess


fetchRelatedArtists : String -> String -> Cmd ExploreMsg
fetchRelatedArtists artistId token =
    get (fetchRelatedArtistsUrl artistId) relatedArtistsDecoder token
        |> RemoteData.sendRequest
        |> Cmd.map Explore.RelatedArtistsSuccess


fetchArtistById : String -> String -> Cmd ExploreMsg
fetchArtistById artistId token =
    get (fetchArtistByIdUrl artistId) artistDecoder token
        |> RemoteData.sendRequest
        |> Cmd.map Explore.ArtistByIdSuccess
