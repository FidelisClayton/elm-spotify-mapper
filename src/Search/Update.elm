module Search.Update exposing (..)

import Commands exposing (fetchArtist, fetchTopTracks)
import Models exposing (Model)
import Msgs exposing (Msg)
import Ports
import RemoteData
import Search.Msgs as Search exposing (SearchMsg)
import Tutorial.Msgs as Tutorial
import Tutorial.Update exposing (addSteps)


updateSearch : SearchMsg -> Model -> ( Model, Cmd Msg )
updateSearch msg model =
    case msg of
        Search.Search term ->
            let
                cmd =
                    if String.length term > 1 then
                        case model.auth of
                            Just { accessToken } ->
                                Cmd.map Msgs.MsgForSearch (fetchArtist term accessToken)
                            _ ->
                                Cmd.none
                    else
                        Cmd.none
            in
            ( { model | searchTerm = term }, cmd )

        Search.SearchArtistSuccess response ->
            case response of
                RemoteData.Success data ->
                    let
                        steps =
                            [ Tutorial.artistResult ]

                        newTutorial =
                            model.tutorial
                                |> addSteps steps
                    in
                    ( { model | artists = response, tutorial = newTutorial }, Ports.addSteps steps )

                _ ->
                    ( { model | artists = response }, Cmd.none )

        Search.StartSearch ->
            ( { model | searching = True }, Cmd.none )

        Search.SelectArtist artist ->
            let
                newModel =
                    { model
                        | selectedArtist = Maybe.Just artist
                        , route = Models.ExploreRoute
                    }

                token =
                    case model.auth of
                        Just auth ->
                            auth.accessToken
                        Nothing ->
                            ""

            in
            ( newModel
            , Cmd.batch
                [ Cmd.map Msgs.MsgForSidebar (fetchTopTracks artist.id token)
                , Ports.nextStep ""
                ]
            )
