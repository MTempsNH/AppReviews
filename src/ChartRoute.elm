module ChartRoute exposing (..)

import Html exposing (Html, div, text)
import Models exposing (Model)

chartRoute : Model -> Html msg
chartRoute model =
    div []
        [ text model.listOfApps]