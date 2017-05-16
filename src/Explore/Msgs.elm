module Explore.Msgs exposing (..)

import RemoteData exposing (WebData)
import Models exposing (VisNode, VisEdge, Artist, RelatedArtists)

type ExploreMsg
  = OnVisNodeClick String
  | UpdateNetwork (List VisNode, List VisEdge)
  | ArtistByIdSuccess (WebData Artist)
  | OnDoubleClick String
  | RelatedArtistsSuccess (WebData RelatedArtists)
  | AddTracks
  | SavePlaylist
