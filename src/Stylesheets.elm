port module Stylesheets exposing (..)

import BottomBar.Style as BottomBar
import Css.File exposing (..)
import Dialog.Style as Dialog
import Explore.Style as Explore
import FlashMessage.Style as FlashMessage
import MainContent.Style as MainContent
import Search.Style as Search
import Sidebar.Style as Sidebar
import Style as Main
import Playlist.Style as Playlist


port files : CssFileStructure -> Cmd msg


cssFiles : CssFileStructure
cssFiles =
    toFileStructure
        [ ( "spotify-mapper.css"
          , compile
                [ BottomBar.css
                , Sidebar.css
                , Main.css
                , MainContent.css
                , Explore.css
                , FlashMessage.css
                , Dialog.css
                , Search.css
                , Playlist.css
                ]
          )
        ]


main : CssCompilerProgram
main =
    Css.File.compiler files cssFiles
