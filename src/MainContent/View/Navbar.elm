module MainContent.View.Navbar exposing (..)

import Html exposing (Html, div, a, text)
import Html.Attributes exposing (href)
import Helpers exposing (cssClass)
import MainContent.Style exposing (Classes(Navbar, NavbarItem, Active))
import Models exposing (Model, Route(ExploreRoute, PlaylistRoute))
import Msgs exposing (Msg)


setItemStyles : Route -> Model -> List Classes
setItemStyles route model =
    if route == model.route then
        [ NavbarItem, Active ]
    else
        [ NavbarItem ]


exploreItem : Model -> Html Msg
exploreItem model =
    a
        [ cssClass <| setItemStyles ExploreRoute model
        , href "#/explore"
        ]
        [ text "Explore" ]


playlistItem : Model -> Html Msg
playlistItem model =
    a
        [ cssClass <| setItemStyles PlaylistRoute model
        , href "#/playlist"
        ]
        [ text "Playlist" ]


navbar : Model -> Html Msg
navbar model =
    div [ cssClass [ Navbar ] ]
        [ exploreItem model
        , playlistItem model
        ]
