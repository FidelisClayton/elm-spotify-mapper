module Components.BottomBar.Style exposing (..)

import Css exposing (..)
import Css.Namespace exposing (namespace)
import Html.CssHelpers exposing (withNamespace)

import CssClasses

css =
  (stylesheet << namespace "")
  [ class CssClasses.BottomBar
      [ backgroundColor <| hex "282828"
      , color <| hex "FFF"
      , displayFlex
      , height <| px 90
      , padding3 zero (px 16) (px 10)
      , displayFlex
      , alignItems center
      , justifyContent center
      ]

  , class CssClasses.ProgressGroup
      [ displayFlex
      , alignItems center
      ]

  , class CssClasses.ProgressBar
      [ backgroundColor <| hex "404040"
      , width (px 500)
      , height (px 4)
      , borderRadius (px 10)
      , displayFlex
      , margin2 zero (px 10)

      , children [
          class CssClasses.Progress
            [ backgroundColor <| hex "a0a0a0"
            , width (pct 85)
            , height (pct 100)
            , borderRadius (px 10)

            , hover
                [ backgroundColor <| hex "1db954"]
            ]
        ]
      ]

    , class CssClasses.FontSmall
        [ fontSize (px 11) ]

    , class CssClasses.ControlIcon
        [ backgroundColor <| hex "00F"
        , width <| px 32
        , height <| px 32
        , margin2 zero (px 10)
        ]

    , class CssClasses.ControlButtons
        [ displayFlex
        , flexDirection row
        , height <| px 50
        , justifyContent center
        , alignItems center
        ]
  ]
