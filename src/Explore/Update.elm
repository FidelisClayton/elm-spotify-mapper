module Explore.Update exposing (..)

import Msgs exposing (Msg)
import Explore.Msgs as Explore exposing (ExploreMsg)
import Models exposing (Model)
import Commands exposing (fetchRelatedArtists, fetchTopTracks, fetchArtistById)
import Ports exposing (addSimilar)
import RemoteData exposing (WebData)
import Constants exposing (maxRelatedArtists)
import Helpers

updateExplore : ExploreMsg -> Model -> (Model, Cmd Msg)
updateExplore msg model =
  case msg of
    Explore.OnVisNodeClick artistId ->
      ({ model | topTracks = RemoteData.Loading }, Cmd.map Msgs.MsgForExplore (fetchArtistById artistId))

    Explore.ArtistByIdSuccess response ->
      case response of
        RemoteData.Success artist ->
          let
            commands = Cmd.batch
              [ Cmd.map Msgs.MsgForExplore (fetchRelatedArtists artist.id)
              , Cmd.map Msgs.MsgForSidebar (fetchTopTracks artist.id)
              ]

            newModel =
              if (List.length <| Helpers.filterArtistsWithRelated artist.id model.playlistArtists) > 0 then
                ({ model
                | selectedArtist = Just artist
                }
                , Cmd.map Msgs.MsgForSidebar (fetchTopTracks artist.id)
                )
              else
                let
                  newArtist = { artist | hasRelated = True }
                in
                  ({ model
                  | selectedArtist = Just newArtist
                  , playlistArtists = newArtist :: model.playlistArtists
                  }
                  , commands
                  )
          in
            newModel

        _ ->
          (model, Cmd.none)

    Explore.UpdateNetwork data ->
      let
        previousNetwork = model.network

        newNetwork =
          { previousNetwork | nodes = previousNetwork.nodes, edges = previousNetwork.edges }
      in
        ({ model | network = newNetwork }, Cmd.none)

    Explore.OnDoubleClick artistId ->
      ({ model | waitingToPlay = True }, Cmd.none)

    Explore.RelatedArtistsSuccess response ->
      case response of
        RemoteData.Success data ->
          let
            newArtists =
                Helpers.filterNewArtists data.artists model.network.nodes
                |> List.take maxRelatedArtists

            nodes =
              List.map Helpers.artistToNode newArtists

            edges =
              case model.selectedArtist of
                Just artist ->
                  Helpers.filterNewArtists data.artists model.network.nodes
                  |> List.take maxRelatedArtists
                  |> Helpers.artistsToEdge artist.id

                Nothing ->
                  []

            newNodes =
              List.append model.network.nodes nodes

            newEdges =
              List.append model.network.edges edges

            previousNetwork = model.network

            newNetwork =
              { previousNetwork | nodes = newNodes, edges = newEdges }

            newPlaylistArtists =
              List.append model.playlistArtists newArtists

            newModel =
              { model
              | relatedArtists = response
              , network = newNetwork
              , playlistArtists = newPlaylistArtists
              }
          in
            (newModel, addSimilar (nodes, edges))

        _ ->
          ({ model | relatedArtists = response }, Cmd.none)
