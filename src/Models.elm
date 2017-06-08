module Models exposing (..)

import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required, requiredAt, optional, hardcoded)
import RemoteData exposing (WebData)

import Spotify.Models exposing (User, Playlist)
import FlashMessage.Models as FlashMessage
import Tutorial.Msgs exposing (TutorialModel, initTutorial)

type alias Flags =
  { spotifyConfig: SpotifyConfig
  , auth: Maybe SpotifyAuthData
  }

type alias SpotifyConfig =
  { clientId: String
  , clientSecret: String
  , redirectUri: String
  }

type alias SpotifyAuthData =
  { accessToken: String
  , expiresIn: Int
  , tokenType: String
  }

type alias Model =
  { showMenu : Bool
  , artists : WebData SearchArtistData
  , searching : Bool
  , searchTerm : String
  , topTracks : WebData TopTracks
  , selectedArtist : Maybe Artist
  , selectedTrack : Maybe Track
  , isPlaying : Bool
  , audioStatus : AudioStatus
  , route : Route
  , network : VisNetwork
  , relatedArtists : WebData RelatedArtists
  , playlistArtists : List Artist
  , waitingToPlay : Bool
  , spotifyConfig : SpotifyConfig
  , auth : Maybe SpotifyAuthData
  , user : WebData User
  , playlist : Playlist
  , flashMessage : FlashMessage.Model
  , clientAuthData : SpotifyAuthData
  , tutorial: TutorialModel
  }

initialModel : Route -> Flags -> Model
initialModel route flags =
  { showMenu = True
  , artists = RemoteData.NotAsked
  , searching = False
  , searchTerm = ""
  , topTracks = RemoteData.NotAsked
  , selectedArtist = Maybe.Nothing
  , selectedTrack = Maybe.Nothing
  , isPlaying = False
  , audioStatus = AudioStatus 0 30 0.4
  , route = route
  , network = VisNetwork [] []
  , relatedArtists = RemoteData.NotAsked
  , playlistArtists = []
  , waitingToPlay = False
  , spotifyConfig = flags.spotifyConfig
  , auth = flags.auth
  , user = RemoteData.NotAsked
  , playlist = Playlist "" "" "Spotify Mapper -" (User "" "" "") []
  , flashMessage = FlashMessage.initialModel
  , clientAuthData = SpotifyAuthData "" 0 ""
  , tutorial = initTutorial
  }

type Route
  = SearchRoute
  | ExploreRoute
  | NotFoundRoute

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
  , hasRelated : Bool
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
  , uri : String
  }

type alias SearchArtistData =
  { items : List Artist }

type alias TopTracks =
  { tracks : List Track }

type alias RelatedArtists =
  { artists : List Artist }

type alias AudioStatus =
  { currentTime : Float
  , duration : Float
  , volume : Float
  }

type alias VisNode =
  { id : String
  , label : String
  , value : Int
  , shape : String
  , image : String
  }

type alias VisEdge =
  { from : String
  , to : String
  }

type alias VisNetwork =
  { nodes : List VisNode
  , edges : List VisEdge
  }

searchArtistDecoder : Decode.Decoder SearchArtistData
searchArtistDecoder =
  decode SearchArtistData
    |> requiredAt ["artists", "items"] (Decode.list artistDecoder)

topTracksDecoder : Decode.Decoder TopTracks
topTracksDecoder =
  decode TopTracks
    |> required "tracks" (Decode.list trackDecoder)

relatedArtistsDecoder : Decode.Decoder RelatedArtists
relatedArtistsDecoder =
  decode RelatedArtists
    |> required "artists" (Decode.list artistDecoder)

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
    |> hardcoded False

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
    |> optional "preview_url" Decode.string ""
    |> required "uri" Decode.string

authDataDecoder : Decode.Decoder SpotifyAuthData
authDataDecoder =
  decode SpotifyAuthData
    |> required "access_token" Decode.string
    |> required "expires_in" Decode.int
    |> required "token_type" Decode.string
