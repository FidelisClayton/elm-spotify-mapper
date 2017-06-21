module FlashMessage.Style exposing (..)

import Css exposing (..)
import Css.Elements exposing (i, input)
import Css.Namespace exposing (namespace)
import CssClasses
import Html.CssHelpers exposing (withNamespace)


css =
    (stylesheet << namespace "")
        [ class CssClasses.FlashMessage
            [ position absolute
            , width <| pct 100
            , color <| hex "FFF"
            , backgroundColor <| hex "5a7ce0"
            , zIndex <| int 100
            , textAlign center
            , fontSize <| pt 9
            , padding2 (px 2) zero
            , withClass CssClasses.Hidden
                [ display none
                ]
            ]
        , class CssClasses.CloseButton
            [ position absolute
            , right <| px 10
            , cursor pointer
            , padding2 (px 2) (px 10)
            , top zero
            ]
        ]
