module MainContent.Style exposing (..)

import Css exposing (..)
import Css.Namespace exposing (namespace)


type Classes
    = Content
    | Main
    | BigSearch
    | SearchResults
    | ArtistResult
    | ImageWrapper


css : Stylesheet
css =
    (stylesheet << namespace "")
        [ class Main
            [ width <| pct 100
            , displayFlex
            , flexDirection column
            , property "overflow-y" "overlay"
            , overflowX hidden
            , position relative
            ]
        ]
