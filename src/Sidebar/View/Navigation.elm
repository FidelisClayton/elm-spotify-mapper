module Sidebar.View.Navigation exposing (..)

import Constants
import Css exposing (property)
import CssClasses exposing (Ids(TutExplore, TutSearch))
import Html exposing (Html, a, button, div, i, img, input, span, text)
import Html.Attributes exposing (href, placeholder, src, target, type_)
import Html.CssHelpers
import Html.Events exposing (onClick)
import Models exposing (Model, TopTracks, Track)
import Msgs exposing (Msg)
import RemoteData exposing (WebData)
import Search.Msgs as Search exposing (SearchMsg)
import Sidebar.Msgs as Sidebar exposing (SidebarMsg)
import Sidebar.Style exposing (Classes(Active, Logo, NavGroup, SidebarLink))


{ class, id } =
    Html.CssHelpers.withNamespace ""


styles =
    Css.asPairs >> Html.Attributes.style


navItem : List (Html Msg) -> Html Msg
navItem childrens =
    div [ class [ NavGroup ] ]
        childrens


navMenu : Model -> Html Msg
navMenu model =
    let
        searchClasses =
            if model.route == Models.SearchRoute then
                [ SidebarLink, Active ]
            else
                [ SidebarLink ]

        exploreClasses =
            if model.route == Models.ExploreRoute then
                [ SidebarLink, Active ]
            else
                [ SidebarLink ]
    in
    div []
        [ navItem
            [ span [ class [ Logo ] ]
                [ i [ Html.Attributes.class "fa fa-spotify" ] [] ]
            ]
        , navItem
            [ a
                [ class searchClasses
                , href "#/search"
                , id [ TutSearch ]
                ]
                [ text "Search" ]
            , a
                [ class exploreClasses
                , href "#/explore"
                , id [ TutExplore ]
                ]
                [ text "Explore" ]
            ]
        ]
