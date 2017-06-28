module Routing exposing (..)

import Navigation exposing (Location)
import Models exposing (Model, Route(..))
import UrlParser exposing (..)
import Debug exposing (log)

matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map HomeRoute top
        , map ChartRoute (s "chart")
        ]

parseLocation : Location -> Route
parseLocation location =
    case (parseHash matchers location) of
        Just route ->
            route

        Nothing ->
            NoRouteFound