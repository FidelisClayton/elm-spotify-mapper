module Components.MainContent.View exposing (..)

import Html exposing (Html, div, text, input, label, img, i)
import Html.Attributes exposing (type_, placeholder, src)
import Html.CssHelpers

import Models exposing (Model, Artist)
import Msgs exposing (Msg)
import CssClasses

{ class } =
  Html.CssHelpers.withNamespace ""

bigSearch : Model -> Html Msg
bigSearch model =
  div [ class [ CssClasses.BigSearch ] ]
    [ label [] [ text "Search for an artist" ]
    , input [ type_ "text" ] [] ]

searchResult : Artist -> Html Msg
searchResult artist =
  div [ class [ CssClasses.ArtistResult ] ]
    [ div [ class [ CssClasses.ImageWrapper ] ]
          [ div []
              [ i [ Html.Attributes.class "fa fa-play" ] [] ]
          , img [ src "https://pbs.twimg.com/profile_images/766360293953802240/kt0hiSmv.jpg" ] []
          ]
    , label [] [ text <| .name artist ]
    ]

searchResults : Model -> Html Msg
searchResults model =
  div [ class [ CssClasses.SearchResults ] ]
    [ searchResult metallica
    , searchResult metallica
    , searchResult metallica
    , searchResult metallica
    ]

metallica : Artist
metallica =
  { genres = [ "Metal" ]
  , href = ""
  , id = ""
  , name = "Metallica"
  , popularity = 1000
  , type_ = "Test"
  , uri = "test"
  }

render : Model -> Html Msg
render model =
  div [ class [ CssClasses.Main ] ]
    [ bigSearch model
    , searchResults model
    ]
