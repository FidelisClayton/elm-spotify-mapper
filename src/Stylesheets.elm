port module Stylesheets exposing (..)

import Css.File exposing (..)

import Style as Main
import Components.BottomBar.Style as BottomBar
import Components.Navbar.Style as Navbar
import Components.Sidebar.Style as Sidebar

port files : CssFileStructure -> Cmd msg

cssFiles : CssFileStructure
cssFiles =
  toFileStructure
    [ ("spotify-mapper.css",
        compile
          [ BottomBar.css, Navbar.css, Sidebar.css, Main.css ]
      )
    ]

main : CssCompilerProgram
main =
  Css.File.compiler files cssFiles
