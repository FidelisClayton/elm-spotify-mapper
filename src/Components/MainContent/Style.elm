module Components.MainContent.Style exposing (..)

import Css exposing (..)
import Css.Elements exposing (input, label)
import Css.Namespace exposing (namespace)
import Html.CssHelpers exposing (withNamespace)

import CssClasses

css =
  (stylesheet << namespace "")
  [ class CssClasses.Content
      [ displayFlex
      , flex <| int 1
      ]

  , class CssClasses.Main
      [ width <| pct 100
      , displayFlex
      , flexDirection column
      ]

  , class CssClasses.BigSearch
      [ backgroundColor <| hex "242424"
      , height <| px 115
      , padding2 (px 24) (px 32)
      , displayFlex
      , flexDirection column
      , justifyContent spaceAround

      , children
          [ label
              [ color <| hex "FFF"
              ]
          , input
              [ height <| px 74
              , backgroundColor transparent
              , border zero
              , width <| pct 100
              , color <| hex "FFF"
              , fontSize <| px 62
              , lineHeight <| px 74
              , outline none
              ]
          ]
      ]

  , class CssClasses.SearchResults
      [ displayFlex
      , flex <| int 1
      , backgroundColor <| hex "181818"
      ]
  ]
