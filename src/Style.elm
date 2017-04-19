module Style exposing (..)

import Css exposing (..)
import Css.Elements exposing (body)
import Css.Namespace exposing (namespace)
import Html.CssHelpers exposing (withNamespace)

import CssClasses

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
  ]
