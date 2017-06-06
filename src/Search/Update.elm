module Search.Update exposing (..)

import Models exposing (Model)
import Msgs exposing (Msg)
import Commands exposing (fetchArtist, fetchTopTracks)
import Search.Msgs as Search exposing (SearchMsg)

updateSearch : SearchMsg -> Model -> (Model, Cmd Msg)
updateSearch msg model =
  case msg of
    Search.Search term ->
      let
        cmd =
          if String.length term > 1 then
            Cmd.map Msgs.MsgForSearch (fetchArtist term model.clientAuthData.accessToken)
          else
            Cmd.none
      in
        ({ model | searchTerm = term } , cmd)

    Search.SearchArtistSuccess response ->
      ({ model | artists = response }, Cmd.none)

    Search.StartSearch ->
      ({ model | searching = True }, Cmd.none)

    Search.SelectArtist artist ->
      let
        newModel =
          { model
          | selectedArtist = Maybe.Just artist
          , route = Models.ExploreRoute
          }
      in
        (newModel, Cmd.map Msgs.MsgForSidebar (fetchTopTracks artist.id model.clientAuthData.accessToken))
