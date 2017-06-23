module Explore.Style exposing (..)

import Css exposing (..)
import Css.Elements exposing (i, input)
import Css.Namespace exposing (namespace)
import Html.CssHelpers exposing (withNamespace)


type Classes
    = VisContainer
    | BtnSavePlaylist
    | Navbar
    | NavbarItem
    | Active


css =
    (stylesheet << namespace "")
        [ class VisContainer
            [ position absolute
            , width <| pct 100
            , height <| pct 100
            , overflow hidden
            ]
        , class BtnSavePlaylist
            [ position absolute
            , width <| px 50
            , height <| px 50
            , borderRadius <| pct 50
            , bottom zero
            , right zero
            , marginRight <| px 30
            , marginBottom <| px 10
            , backgroundColor <| hex "1db954"
            , cursor pointer
            , zIndex <| int 10
            , children
                [ i
                    [ lineHeight <| px 50
                    , textAlign center
                    , width <| pct 100
                    , color <| hex "FFF"
                    ]
                ]
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
