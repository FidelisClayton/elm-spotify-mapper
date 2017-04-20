module Components.Sidebar.View exposing (..)

import Html exposing (Html, div, text, input, span, img)
import Html.Attributes exposing (type_, placeholder, src)
import Html.CssHelpers

import Models exposing (Model)
import Msgs exposing (Msg)

import CssClasses

{ class } =
  Html.CssHelpers.withNamespace ""

navItem : List (Html Msg) -> Html Msg
navItem childrens =
  div [ class [ CssClasses.NavGroup ] ]
      childrens

artistSongs : Model -> Html Msg
artistSongs model =
  div [ class [ CssClasses.NavGroup, CssClasses.ArtistSongs ] ]
      []

userProfile : Model -> Html Msg
userProfile model =
  navItem
    [ div [ class [ CssClasses.UserProfile ] ]
        [ img
            [ src "http://i3.kym-cdn.com/photos/images/facebook/000/120/409/03e.png"
            , class [ CssClasses.RoundedImage, CssClasses.UserImage ]
            ] []
        , span [ class [ CssClasses.FontMedium ] ]
            [ text "Gabe Newell" ]
        ]
    ]

render : Model -> Html Msg
render model =
  div [ class [ CssClasses.Sidebar ] ]
      [ navItem
          [ span [ class [ CssClasses.Logo] ]
              [ text "Spotify Mapper" ] 
          ]
      , navItem
          [ input
              [ type_ "text"
              , class [ CssClasses.SearchInput ]
              , placeholder "Search"
              ]
              []
          ]
      , artistSongs model
      , userProfile model
      ]
