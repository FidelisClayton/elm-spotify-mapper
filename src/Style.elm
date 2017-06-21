module Style exposing (..)

import Css exposing (..)
import Css.Elements exposing (body)
import Css.Namespace exposing (namespace)
import CssClasses
import Html.CssHelpers exposing (withNamespace)


css =
    (stylesheet << namespace "")
        [ body
            [ margin zero
            , padding zero
            ]
        , class CssClasses.Container
            [ displayFlex
            , flexDirection column
            , position absolute
            , width <| pct 100
            , height <| pct 100
            ]
        , class CssClasses.MenuToggler
            [ width <| px 30
            , height <| px 30
            , outline none
            , border zero
            ]
        , class CssClasses.SearchInput
            [ height <| px 22
            , outline none
            , backgroundColor <| rgba 0 0 0 0
            , border zero
            , color <| hex "FFF"
            , padding2 (px 3) zero
            , margin2 (px 3) zero
            , fontSize <| px 16
            , lineHeight <| px 16
            , fontWeight bold
            ]
        ]
