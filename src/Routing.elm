module Routing exposing (..)

import Models exposing (Route)
import Navigation exposing (Location)
import UrlParser exposing (..)


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map Models.SearchRoute top
        , map Models.ExploreRoute (s "explore")
        , map Models.SearchRoute (s "search")
        ]


parseLocation : Location -> Route
parseLocation location =
    case parseHash matchers location of
        Just route ->
            route

        Nothing ->
            Models.NotFoundRoute
