module Explore.Style exposing (..)

import Css exposing (..)
import Css.Elements exposing (i, input)
import Css.Namespace exposing (namespace)
import CssClasses
import Html.CssHelpers exposing (withNamespace)


css =
    (stylesheet << namespace "")
        [ class CssClasses.VisContainer
            [ position absolute
            , width <| pct 100
            , height <| pct 100
            , overflow hidden
            ]
        , class CssClasses.SavePlaylist
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
        ]
