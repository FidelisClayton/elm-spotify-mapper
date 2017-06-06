module Search.Update exposing (..)

import RemoteData
import Models exposing (Model)
import Msgs exposing (Msg)
import Commands exposing (fetchArtist, fetchTopTracks)
import Search.Msgs as Search exposing (SearchMsg)
import Tutorial.Update exposing (addSteps)
import Ports

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
      case response of
        RemoteData.Success data ->
          let
            steps = [
              { id = "artist-result"
              , title = "Artist"
              , text = "You can click on an artist to start to discover artists related."
              , attachTo = ".ImageWrapper bottom"
              , advanceOn = Just ".ArtistResult click"
              , done = False
              }
            ]

            newTutorial =
              model.tutorial
                |> addSteps steps
          in
          ({ model | artists = response, tutorial = newTutorial }, Ports.addSteps steps)
        _ ->
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
        (newModel, 
          Cmd.batch
            [ Cmd.map Msgs.MsgForSidebar (fetchTopTracks artist.id model.clientAuthData.accessToken)
            , Ports.nextStep ""
            ]
        )
