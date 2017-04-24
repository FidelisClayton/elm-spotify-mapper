module Explore.Style exposing (..)

import Css exposing (..)
import Css.Elements exposing (input)
import Css.Namespace exposing (namespace)
import Html.CssHelpers exposing (withNamespace)

import CssClasses

css =
  (stylesheet << namespace "")
  [ class CssClasses.VisContainer
      [ position absolute
      , width <| pct 100
      , height <| pct 100
      ]
  ]
