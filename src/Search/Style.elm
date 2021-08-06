module Search.Style exposing (..)

import Css exposing (..)
import Css.Elements exposing (div, i, img, input, label)
import Css.Namespace exposing (namespace)
import CssClasses
import Html.CssHelpers exposing (withNamespace)


type Classes
    = Content
    | Main
    | BigSearch
    | SearchResults
    | ArtistResult
    | ImageWrapper
    | Image
    | Play


css =
    (stylesheet << namespace "")
        [ class BigSearch
            [ backgroundColor <| hex "242424"
            , height <| px 115
            , padding2 (px 24) (px 32)
            , displayFlex
            , flexDirection column
            , justifyContent spaceAround
            , children
                [ label
                    [ color <| hex "FFF"
                    ]
                , input
                    [ height <| px 74
                    , backgroundColor transparent
                    , border zero
                    , width <| pct 100
                    , color <| hex "FFF"
                    , fontSize <| px 62
                    , lineHeight <| px 74
                    , outline none
                    ]
                ]
            ]
        , class SearchResults
            [ displayFlex
            , flex <| int 1
            , backgroundColor <| hex "181818"
            , flexWrap wrap
            , justifyContent flexStart
            ]
        , class ArtistResult
            [ displayFlex
            , flexDirection column
            , alignItems center
            , margin <| px 15
            , position relative
            , width <| px 180
            , textDecoration none
            , children
                [ class ImageWrapper
                    [ width <| px 180
                    , height <| px 180
                    , position relative
                    , children
                        [ each [ img, div ]
                            [ width <| pct 100
                            , height <| pct 100
                            , borderRadius <| pct 50
                            ]
                        , class Image
                            [ backgroundPosition center
                            , backgroundSize cover
                            ]
                        , class Play
                            [ backgroundColor <| rgba 0 0 0 0.5
                            , position absolute
                            , displayFlex
                            , alignItems center
                            , justifyContent center
                            , opacity <| int 0
                            , property "transition" "0.3s ease all"
                            , hover
                                [ opacity <| int 1
                                , cursor pointer
                                ]
                            , children
                                [ i
                                    [ color <| hex "FFF"
                                    , fontSize <| px 22
                                    ]
                                ]
                            ]
                        ]
                    ]
                , label
                    [ color <| hex "FFF"
                    , padding2 (px 10) zero
                    ]
                ]
            ]
        ]
