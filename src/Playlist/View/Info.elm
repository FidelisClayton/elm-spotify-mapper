module Playlist.View.Info exposing (..)

import Html exposing (Html, div, text, p, h3, img, button)
import Html.Attributes exposing (src)
import Models exposing (Model)
import Msgs exposing (Msg)
import Playlist.Style exposing (Classes(PlaylistInfo, PlaylistTitle, PlaylistCover, PlaylistDescription, BtnSave))
import Helpers exposing (cssClass)


playlistInfo : Model -> Html Msg
playlistInfo model =
    div [ cssClass [ PlaylistInfo ] ]
        [ img
            [ src "http://www.baixarsomgratis.com/wp-content/uploads/2015/05/cd-matanza-a-arte-do-insulto.jpg"
            , cssClass [ PlaylistCover ]
            ]
            []
        , h3
            [ cssClass [ PlaylistTitle ] ]
            [ text "Radar de Novidades" ]
        , p
            [ cssClass [ PlaylistDescription ] ]
            [ text "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc viverra sem id felis malesuada aliquam. Pellentesque pretium sagittis ornare. Interdum et malesuada fames ac ante ipsum primis in faucibus." ]
        , button
            [ cssClass [ BtnSave ] ]
            [ text "Save" ]
        ]
