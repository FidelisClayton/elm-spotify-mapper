module Models exposing (..)

import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required, requiredAt)
import RemoteData exposing (WebData)


type alias Model =
  { showMenu : Bool
  , artists : WebData SearchArtistData
  , searching : Bool
  }

initialModel : Model
initialModel =
  { showMenu = True
  , artists = RemoteData.Loading
  , searching = False
  }

type alias ExternalUrl =
  { key : String
  , value : String
  }

type alias Followers =
  { href : String
  , total : Int
  }

type alias ImageObject =
  { height : Int
  , url : String
  , width : Int
  }

-- TODO: Add external_urls, followers and images
type alias Artist =
  { genres : List String
  , href : String
  , id : String
  , name : String
  , popularity : Int
  , type_ : String
  , uri : String
  , images : List ImageObject
  }

type alias SearchArtistData =
  { items : List Artist }

type alias ArtistsData =
  { items : List Artist
  }

imageDecoder : Decode.Decoder ImageObject
imageDecoder =
  decode ImageObject
    |> required "height" Decode.int
    |> required "url" Decode.string
    |> required "width" Decode.int

searchArtistDecoder : Decode.Decoder SearchArtistData
searchArtistDecoder =
  decode SearchArtistData
    |> requiredAt ["artists", "items"] (Decode.list artistDecoder)

artistDecoder : Decode.Decoder Artist
artistDecoder =
  decode Artist
    |> required "genres" (Decode.list Decode.string)
    |> required "href" Decode.string
    |> required "id" Decode.string
    |> required "name" Decode.string
    |> required "popularity" Decode.int
    |> required "type" Decode.string
    |> required "uri" Decode.string
    |> required "images" (Decode.list imageDecoder)
