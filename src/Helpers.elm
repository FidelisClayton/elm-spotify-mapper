module Helpers exposing (..)

import Css
import Html
import Html.Attributes
import Html.CssHelpers
import Models exposing (Artist, ImageObject, VisEdge, VisNode)
import Spotify.Models exposing (Track)


firstImageUrl : List ImageObject -> String
firstImageUrl images =
    case List.head images of
        Just image ->
            image.url

        Nothing ->
            ""


firstArtistName : List Artist -> String
firstArtistName artists =
    case List.head artists of
        Just artist ->
            artist.name

        Nothing ->
            ""


paddValue : Float -> String
paddValue value =
    if value < 10 then
        "0" ++ toString value
    else
        toString value


getPct : Float -> Float -> Float
getPct current max =
    (current * 100) / max


pctToValue : Float -> Float -> Float
pctToValue current max =
    (current * max) / 100


getByIndex : Int -> List a -> Maybe a
getByIndex index items =
    List.take index items
        |> List.reverse
        |> List.head


getLastItem : List a -> Maybe a
getLastItem items =
    List.reverse items
        |> List.head


artistToNode : Artist -> VisNode
artistToNode artist =
    let
        image =
            case getLastItem artist.images of
                Just image ->
                    image.url

                Nothing ->
                    ""
    in
        { id = artist.id
        , label = artist.name
        , value = artist.popularity
        , shape = "circularImage"
        , image = image
        }


artistsToEdge : String -> List Artist -> List VisEdge
artistsToEdge fromId artists =
    List.map
        (\artist ->
            VisEdge fromId artist.id
        )
        artists


filterNewArtists : List Artist -> List VisNode -> List Artist
filterNewArtists artists nodes =
    List.filter
        (\artist ->
            let
                repeatedNodes =
                    List.filter
                        (\node ->
                            node.id == artist.id
                        )
                        nodes
            in
                not (List.length repeatedNodes > 0)
        )
        artists


filterArtistsWithRelated : String -> List Artist -> List Artist
filterArtistsWithRelated id artists =
    filterArtistById id artists
        |> List.filter (\artist -> artist.hasRelated)


filterArtistById : String -> List Artist -> List Artist
filterArtistById id artists =
    List.filter (\artist -> artist.id == id) artists


filterTrackById : String -> List Track -> List Track
filterTrackById id tracks =
    List.filter
        (\track ->
            track.id == id
        )
        tracks


filterNewTracks : List Track -> List Track -> List Track
filterNewTracks oldTracks newTracks =
    List.filter
        (\track ->
            List.isEmpty (filterTrackById track.id oldTracks)
        )
        newTracks


toSpotifyTrack : Models.Track -> Spotify.Models.Track
toSpotifyTrack track =
    let
        artists =
            List.map (\artist -> artist.name) track.artists
    in
        Track track.id track.name track.preview_url track.uri artists


firstArtist : List Artist -> Maybe Artist
firstArtist artists =
    List.filter (\artist -> artist.hasRelated) artists
        |> List.reverse
        |> List.head


joinWithComma : String -> String -> String
joinWithComma stringA stringB =
    if String.length stringB > 0 then
        stringA ++ ", " ++ stringB
    else
        stringA ++ stringB ++ "."


generatePlaylistDescription : List Artist -> String
generatePlaylistDescription artists =
    List.filter (\artist -> artist.hasRelated) artists
        |> List.map (\artist -> artist.name)
        |> List.foldr joinWithComma ""


cssClass : List class -> Html.Attribute msg
cssClass =
    let
        { class } =
            Html.CssHelpers.withNamespace ""
    in
        class


cssId : id -> Html.Attribute msg
cssId =
    let
        { id } =
            Html.CssHelpers.withNamespace ""
    in
        id


cssStyles =
    Css.asPairs >> Html.Attributes.style
