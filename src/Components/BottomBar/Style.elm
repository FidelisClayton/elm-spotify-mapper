module Components.BottomBar.Style exposing (..)

import Css exposing (..)
import Css.Namespace exposing (namespace)
import Html.CssHelpers exposing (withNamespace)

import CssClasses

css =
  (stylesheet << namespace "")
  [ class CssClasses.BottomBar
      [ backgroundColor <| hex "0F0"
      , displayFlex
      , height <| px 50
      , width <| pct 100
      ]
  ]
