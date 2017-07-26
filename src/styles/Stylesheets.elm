port module Stylesheets exposing (..)

import Css.File exposing (CssFileStructure, CssCompilerProgram)
import DateTimePicker.Css


port files : CssFileStructure -> Cmd msg


fileStructure : CssFileStructure
fileStructure =
    Css.File.toFileStructure
        [ ( "datePicker.css", Css.File.compile [ DateTimePicker.Css.css ] ),
         ( "layout.css" )]


main : CssCompilerProgram
main =
    Css.File.compiler files fileStructure