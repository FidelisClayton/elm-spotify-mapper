module Sidebar.Style exposing (..)

import Css exposing (..)
import Css.Elements exposing (button, img)
import Css.Namespace exposing (namespace)
import CssClasses
import Html.CssHelpers exposing (withNamespace)


css =
    (stylesheet << namespace "")
        [ class CssClasses.Sidebar
            [ width <| px 200
            , transform <| translateX <| px 0
            , property "transition" "0.3s ease all"
            , displayFlex
            , flexDirection column
            , padding <| px 20
            , backgroundColor <| rgba 0 0 0 0.5
            , withClass CssClasses.SidebarActive
                [ transform <| translateX <| px -200 ]
            ]
        , class CssClasses.NavGroup
            [ padding2 (px 10) zero
            , borderBottom3 (px 1) solid (rgba 183 183 183 0.42)
            ]
        , class CssClasses.SidebarLink
            [ color <| hex "a0a0a0"
            , fontWeight bold
            , textDecoration none
            , fontSize <| px 16
            , letterSpacing <| px 0.5
            , display block
            , padding2 (px 10) zero
            , withClass CssClasses.Active
                [ color <| hex "1db954" ]
            , hover
                [ color <| hex "FFF" ]
            ]
        , class CssClasses.Logo
            [ color <| hex "FFF"
            , fontSize <| px 40
            ]
        , class CssClasses.RoundedImage
            [ borderRadius <| pct 50 ]
        , class CssClasses.UserProfile
            [ displayFlex
            , alignItems center
            ]
        , class CssClasses.UserImage
            [ width <| px 28
            , height <| px 28
            , marginRight <| px 10
            ]
        , class CssClasses.Songs
            [ property "overflow" "overlay"
            , flex <| int 1
            ]
        , class CssClasses.SongItem
            [ height <| px 45
            , displayFlex
            , alignItems center
            ]
        , class CssClasses.SongDescription
            [ displayFlex
            , flexDirection column
            , width <| px 130
            , whiteSpace noWrap
            , textOverflow ellipsis
            , display block
            , overflow hidden
            , cursor default
            ]
        , class CssClasses.SongTitle
            [ fontSize <| px 14
            , color <| hex "dcdcdc"
            , lineHeight <| px 20
            , width <| px 130
            , whiteSpace noWrap
            , textOverflow ellipsis
            , display block
            , overflow hidden
            ]
        , class CssClasses.SongAlbumTitle
            [ fontSize <| px 10
            , color <| hex "dcdcdc"
            ]
        , class CssClasses.IsPlaying
            [ color <| hex "FFF"
            , marginLeft <| px 20
            ]
        , class CssClasses.SongCover
            [ width <| px 32
            , height <| px 32
            , marginRight <| px 10
            , position relative
            , children
                [ each [ img, button ]
                    [ width <| pct 100
                    , height <| pct 100
                    ]
                , button
                    [ position absolute
                    , opacity <| int 0
                    , border zero
                    , backgroundColor <| rgba 0 0 0 0.5
                    , color <| hex "FFF"
                    , property "transition" "0.4s ease all"
                    , outline none
                    , hover
                        [ opacity <| int 1
                        , cursor pointer
                        ]
                    ]
                ]
            ]
        , class CssClasses.FontMedium
            [ fontSize <| px 16
            , lineHeight <| px 16
            , color <| hex "FFF"
            ]
        ]
