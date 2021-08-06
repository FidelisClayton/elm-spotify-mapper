module Sidebar.View.LoginProfile exposing (..)

import Constants
import Css exposing (property)
import CssClasses exposing (Ids(TutLogin))
import Html exposing (Html, a, button, div, i, img, input, span, text)
import Html.Attributes exposing (href, placeholder, src, target, type_)
import Html.CssHelpers
import Html.Events exposing (onClick)
import Models exposing (Model, TopTracks, Track)
import Msgs exposing (Msg)
import RemoteData exposing (WebData)
import Search.Msgs as Search exposing (SearchMsg)
import Sidebar.Msgs as Sidebar exposing (SidebarMsg)
import Sidebar.Style exposing (Classes(FontMedium, UserProfile))
import Sidebar.View.Navigation exposing (navItem, navMenu)


{ class, id } =
    Html.CssHelpers.withNamespace ""


styles =
    Css.asPairs >> Html.Attributes.style


login : Model -> Html Msg
login model =
    let
        url =
            Constants.authUrl model.spotifyConfig.clientId model.spotifyConfig.redirectUri
    in
    navItem
        [ div [ class [ UserProfile ], id [ TutLogin ] ]
            [ span [ class [ FontMedium ] ]
                [ a [ href url, target "blank" ] [ text "Login" ]
                ]
            ]
        ]


maybeUser : Model -> Html Msg
maybeUser model =
    case model.user of
        RemoteData.Success user ->
            navItem
                [ div [ class [ UserProfile ] ]
                    [ span [ class [ FontMedium ] ]
                        [ text user.displayName ]
                    ]
                ]

        _ ->
            login model
