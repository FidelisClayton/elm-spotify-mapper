port module Stylesheets exposing (..)

import BottomBar.Style as BottomBar
import Css.File exposing (..)
import Dialog.Style as Dialog
import Explore.Style as Explore
import FlashMessage.Style as FlashMessage
import MainContent.Style as MainContent
import Sidebar.Style as Sidebar
import Style as Main


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
                ]
          )
        ]


main : CssCompilerProgram
main =
    Css.File.compiler files cssFiles
