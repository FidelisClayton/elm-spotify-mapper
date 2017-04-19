module Components.Navbar.Style exposing (..)

import Css exposing (..)
import Css.Namespace exposing (namespace)
import Html.CssHelpers exposing (withNamespace)

import CssClasses

css =
  (stylesheet << namespace "")
  [ class CssClasses.Navbar
      [ displayFlex
      , backgroundColor <| hex "000"
      , color <| hex "fff"
      , height <| px 50
      , width <| pct 100
      , alignItems center
      , padding2 zero (px 15)
      ]
  ]
