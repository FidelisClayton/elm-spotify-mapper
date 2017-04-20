module Models exposing (..)

import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required)
import RemoteData exposing (WebData)


type alias Model =
  { showMenu : Bool
  , artists : WebData SearchArtistData
  }

initialModel : Model
initialModel =
  { showMenu = True
  , artists = RemoteData.Loading
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
  }

type alias SearchArtistData =
  { artists : ArtistsData }

type alias ArtistsData =
  { items : List Artist
  }

searchArtistDecoder : Decode.Decoder SearchArtistData
searchArtistDecoder =
  decode SearchArtistData
    |> required "artists" artistsDataDecoder

artistsDataDecoder : Decode.Decoder ArtistsData
artistsDataDecoder =
  decode ArtistsData
    |> required "items" (Decode.list artistDecoder)

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
