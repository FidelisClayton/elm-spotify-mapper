module Components.Sidebar.Style exposing (..)

import Css exposing (..)
import Css.Namespace exposing (namespace)
import Html.CssHelpers exposing (withNamespace)

import CssClasses

css =
  (stylesheet << namespace "")
  [ class CssClasses.Sidebar
      [ backgroundColor (hex "F00")
      , width <| px 200
      , height <| pct 100
      , transform <| translateX <| px 0
      , property "transition" "0.3s ease all"

      , withClass CssClasses.SidebarActive
          [ transform <| translateX <| px -200 ]
      ]
  ]
