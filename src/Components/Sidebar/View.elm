module Components.Sidebar.View exposing (..)

import Html exposing (Html, div, text, input, span, img, i, button)
import Html.Attributes exposing (type_, placeholder, src)
import Html.Events exposing (onClick)
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
  div [ class [ CssClasses.NavGroup, CssClasses.Songs ] ]
      [ songItem
      , songItem
      , songItem
      ]

songItem : Html Msg
songItem =
  div [ class [ CssClasses.SongItem ] ]
    [ div [ class [ CssClasses.SongCover ] ]
        [ button []
            [ i [ Html.Attributes.class "fa fa-play"] []]
        , img
            [ src "https://upload.wikimedia.org/wikipedia/en/b/b2/Metallica_-_Master_of_Puppets_cover.jpg"]
            []
        ]
    , div [ class [ CssClasses.SongDescription ] ]
        [ span [ class [ CssClasses.SongTitle ] ] [ text "Titulo Musica" ]
        , span [ class [ CssClasses.SongAlbumTitle ] ] [ text "Album" ]
        ]
    , i [ class [ CssClasses.IsPlaying ]
        , Html.Attributes.class "fa fa-volume-up"
        ] []
    ]

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

bigSearch : Model -> Html Msg
bigSearch model =
  div [ class [ CssClasses.BigSearch ] ]
    [ input [ type_ "text" ] [] ]

render : Model -> Html Msg
render model =
  div [ class [ CssClasses.Sidebar ] ]
      [ navItem
          [ span [ class [ CssClasses.Logo] ]
              [ i [ Html.Attributes.class "fa fa-spotify" ] [] ]
          ]
      , navItem
          [ input
              [ type_ "text"
              , class [ CssClasses.SearchInput ]
              , placeholder "Search"
              , onClick Msgs.StartSearch
              ]
              []
          ]
      , artistSongs model
      , userProfile model
      ]
