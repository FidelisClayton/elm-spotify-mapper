module Sidebar.View.Navigation exposing (..)

import Constants
import Css exposing (property)
import CssClasses
import Html exposing (Html, a, button, div, i, img, input, span, text)
import Html.Attributes exposing (href, placeholder, src, target, type_)
import Html.CssHelpers
import Html.Events exposing (onClick)
import Models exposing (Model, TopTracks, Track)
import Msgs exposing (Msg)
import RemoteData exposing (WebData)
import Search.Msgs as Search exposing (SearchMsg)
import Sidebar.Msgs as Sidebar exposing (SidebarMsg)


{ class, id } =
    Html.CssHelpers.withNamespace ""


styles : List Css.Mixin -> Html.Attribute msg
styles =
    Css.asPairs >> Html.Attributes.style


navItem : List (Html Msg) -> Html Msg
navItem childrens =
    div [ class [ CssClasses.NavGroup ] ]
        childrens


navMenu : Model -> Html Msg
navMenu model =
    let
        searchClasses =
            if model.route == Models.SearchRoute then
                [ CssClasses.SidebarLink, CssClasses.Active ]
            else
                [ CssClasses.SidebarLink ]

        exploreClasses =
            if model.route == Models.ExploreRoute then
                [ CssClasses.SidebarLink, CssClasses.Active ]
            else
                [ CssClasses.SidebarLink ]
    in
    div []
        [ navItem
            [ span [ class [ CssClasses.Logo ] ]
                [ i [ Html.Attributes.class "fa fa-spotify" ] [] ]
            ]
        , navItem
            [ a
                [ class searchClasses
                , href "#/search"
                , id [ CssClasses.TutSearch ]
                ]
                [ text "Search" ]
            , a
                [ class exploreClasses
                , href "#/explore"
                , id [ CssClasses.TutExplore ]
                ]
                [ text "Explore" ]
            ]
        ]
