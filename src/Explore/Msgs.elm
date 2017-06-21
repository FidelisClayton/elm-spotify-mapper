module Explore.Msgs exposing (..)

import Models exposing (Artist, RelatedArtists, VisEdge, VisNode)
import RemoteData exposing (WebData)


type ExploreMsg
    = OnVisNodeClick String
    | UpdateNetwork ( List VisNode, List VisEdge )
    | ArtistByIdSuccess (WebData Artist)
    | OnDoubleClick String
    | RelatedArtistsSuccess (WebData RelatedArtists)
    | AddTracks
    | SavePlaylist
