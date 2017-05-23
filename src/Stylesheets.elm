port module Stylesheets exposing (..)

import Css.File exposing (..)

import Style as Main

import BottomBar.Style as BottomBar
import Sidebar.Style as Sidebar
import MainContent.Style as MainContent
import Explore.Style as Explore
import FlashMessage.Style as FlashMessage

port files : CssFileStructure -> Cmd msg

cssFiles : CssFileStructure
cssFiles =
  toFileStructure
    [ ("spotify-mapper.css",
        compile
          [ BottomBar.css
          , Sidebar.css
          , Main.css
          , MainContent.css
          , Explore.css
          , FlashMessage.css
          ]
      )
    ]

main : CssCompilerProgram
main =
  Css.File.compiler files cssFiles
