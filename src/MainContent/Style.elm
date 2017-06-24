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
    | Navbar
    | NavbarItem
    | Active


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
        , class Navbar
            [ displayFlex
            , alignItems center
            , justifyContent center
            , height <| px 80
            , zIndex <| int 10
            ]
        , class NavbarItem
            [ padding2 zero (px 10)
            , property "color" "hsla(0,0%,100%,.5)"
            , textTransform uppercase
            , fontSize <| pt 10
            , letterSpacing <| px 1.5
            , textDecoration none
            , position relative
            , fontWeight bold
            , hover
                [ color <| hex "FFF"
                ]
            , withClass Active
                [ color <| hex "FFF"
                , after
                    [ property "content" "' '"
                    , position absolute
                    , width <| px 20
                    , height <| px 2
                    , backgroundColor <| hex "1db954"
                    , property "left" "calc(50% - 10px)"
                    , marginTop <| px 18
                    ]
                ]
            ]
        ]
