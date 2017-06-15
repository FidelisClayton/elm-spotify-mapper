module Explore.Update exposing (..)

import Msgs exposing (Msg)
import Explore.Msgs as Explore exposing (ExploreMsg)
import Models exposing (Model)
import Commands exposing (fetchRelatedArtists, fetchTopTracks, fetchArtistById)
import Ports exposing (addSimilar)
import RemoteData exposing (WebData)
import Constants exposing (maxRelatedArtists)
import Helpers

import Spotify.Api exposing (addTracks, createPlaylist)
import Spotify.Models exposing (NewPlaylist)
import FlashMessage.Msgs as FlashMessage

updateExplore : ExploreMsg -> Model -> (Model, Cmd Msg)
updateExplore msg model =
  case msg of
    Explore.SavePlaylist ->
      let
        playlistName =
          case (Helpers.firstArtist model.playlistArtists) of
            Just artist ->
              "Spotify Mapper - " ++ artist.name

            Nothing ->
              "Spotify Mapper"

        playlistDescription =
          Helpers.generatePlaylistDescription model.playlistArtists

        -- playlist = NewPlaylist playlistName False False playlistDescription

        oldPlaylist = model.playlist
        newPlaylist =
          { oldPlaylist | name = playlistName, description = playlistDescription }

        oldPlaylistInfo = model.playlistInfo
        newPlaylistInfo =
          { oldPlaylistInfo | name = playlistName , description = playlistDescription }

        newModel =
          { model
          | playlistModalActive = True
          , playlist = newPlaylist
          , playlistInfo = newPlaylistInfo
          }
      in
        newModel ! []

    Explore.AddTracks ->
      let
        uris =
          { uris = List.map (\track -> track.uri) model.playlist.tracks }

        userId =
          model.playlist.owner.id

        playlistId =
          model.playlist.id

        token =
          case model.auth of
            Just auth ->
              auth.accessToken

            Nothing ->
              ""
      in
        (model, Cmd.map Msgs.MsgForSpotify (addTracks userId playlistId uris token) )

    Explore.OnVisNodeClick artistId ->
      ({ model | topTracks = RemoteData.Loading }, Cmd.map Msgs.MsgForExplore (fetchArtistById artistId model.clientAuthData.accessToken))

    Explore.ArtistByIdSuccess response ->
      case response of
        RemoteData.Success artist ->
          let
            commands = Cmd.batch
              [ Cmd.map Msgs.MsgForExplore (fetchRelatedArtists artist.id model.clientAuthData.accessToken)
              , Cmd.map Msgs.MsgForSidebar (fetchTopTracks artist.id model.clientAuthData.accessToken)
              ]

            newModel =
              if (List.length <| Helpers.filterArtistsWithRelated artist.id model.playlistArtists) > 0 then
                ({ model
                | selectedArtist = Just artist
                }
                , Cmd.map Msgs.MsgForSidebar (fetchTopTracks artist.id model.clientAuthData.accessToken)
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
