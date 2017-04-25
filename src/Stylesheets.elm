port module Stylesheets exposing (..)

import Css.File exposing (..)

import Style as Main

import Components.BottomBar.Style as BottomBar
import Components.Sidebar.Style as Sidebar
import Components.MainContent.Style as MainContent
import Explore.Style as Explore

port files : CssFileStructure -> Cmd msg

cssFiles : CssFileStructure
cssFiles =
  toFileStructure
    [ ("spotify-mapper.css",
        compile
          [ BottomBar.css, Sidebar.css, Main.css, MainContent.css, Explore.css ]
      )
    ]

main : CssCompilerProgram
main =
  Css.File.compiler files cssFiles
