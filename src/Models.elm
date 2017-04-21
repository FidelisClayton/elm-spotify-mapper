module Models exposing (..)

import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required, requiredAt, optional)
import RemoteData exposing (WebData)

type alias Model =
  { showMenu : Bool
  , artists : WebData SearchArtistData
  , searching : Bool
  , searchTerm : String
  , topTracks : WebData TopTracks
  , selectedArtist : Maybe Artist
  , selectedTrack : Maybe Track
  }

initialModel : Model
initialModel =
  { showMenu = True
  , artists = RemoteData.NotAsked
  , searching = False
  , searchTerm = ""
  , topTracks = RemoteData.NotAsked
  , selectedArtist = Maybe.Nothing
  , selectedTrack = Maybe.Nothing
  }

type alias ImageObject =
  { height : Int
  , url : String
  , width : Int
  }

type alias Artist =
  { genres : List String
  , href : String
  , id : String
  , name : String
  , popularity : Int
  , uri : String
  , images : List ImageObject
  }

type alias Album =
  { album_type : String
  , artists : List Artist
  , images : List ImageObject
  , name : String
  }

type alias Track =
  { album : Album
  , artists : List Artist
  , id : String
  , name : String
  , preview_url : String
  }

type alias SearchArtistData =
  { items : List Artist }

type alias TopTracks =
  { tracks : List Track }

searchArtistDecoder : Decode.Decoder SearchArtistData
searchArtistDecoder =
  decode SearchArtistData
    |> requiredAt ["artists", "items"] (Decode.list artistDecoder)

topTracksDecoder : Decode.Decoder TopTracks
topTracksDecoder =
  decode TopTracks
    |> required "tracks" (Decode.list trackDecoder)

artistDecoder : Decode.Decoder Artist
artistDecoder =
  decode Artist
    |> optional "genres" (Decode.list Decode.string) []
    |> optional "href" Decode.string ""
    |> required "id" Decode.string
    |> required "name" Decode.string
    |> optional "popularity" Decode.int 0
    |> required "uri" Decode.string
    |> optional "images" (Decode.list imageDecoder) []

imageDecoder : Decode.Decoder ImageObject
imageDecoder =
  decode ImageObject
    |> required "height" Decode.int
    |> required "url" Decode.string
    |> required "width" Decode.int

albumDecoder : Decode.Decoder Album
albumDecoder =
  decode Album
    |> required "album_type" Decode.string
    |> required "artists" (Decode.list artistDecoder)
    |> required "images" (Decode.list imageDecoder)
    |> required "name" Decode.string

trackDecoder : Decode.Decoder Track
trackDecoder =
  decode Track
    |> required "album" albumDecoder
    |> required "artists" (Decode.list artistDecoder)
    |> required "id" Decode.string
    |> required "name" Decode.string
    |> required "preview_url" Decode.string
