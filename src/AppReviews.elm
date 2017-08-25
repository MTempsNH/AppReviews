module AppReviews exposing (..)

import Html exposing (Html, div)
import Html.Attributes exposing (href)
import Http
import Json.Decode exposing (Decoder, at, string)

import DateTimePicker

import Debug exposing (log)
import Models exposing (Model)
import Navigation exposing (Location)
import Routing exposing (parseLocation)

import DemoCss exposing (CssClasses(..))
import Html.CssHelpers

import Form
import NoRouteFound
import ChartRoute

import Msgs exposing (Msg)

{ id, class, classList } =
    Html.CssHelpers.withNamespace ""

init : Location -> (Model, Cmd Msg)
init location =
    let
        initRoute =
            Routing.parseLocation location
    in
        ({
        startDateValue = Nothing,
        startDatePickerState = DateTimePicker.initialState,
        endDateValue = Nothing,
        endDatePickerState = DateTimePicker.initialState,
        listOfApps = "None",
        submitted = False,
        reviewData = "empty",
        inError = False,
        route = initRoute
          }, Cmd.batch
                     [ DateTimePicker.initialCmd Msgs.DateChanged DateTimePicker.initialState,
                      DateTimePicker.initialCmd Msgs.EndDateChanged DateTimePicker.initialState ]
                 )

view : Model -> Html Msg
view model =
    div [ class [ Container ] ]
        [ page model ]

page : Model -> Html Msg
page model =
    case model.route of
        Models.HomeRoute ->
            Form.formView model

        Models.ChartRoute ->
            ChartRoute.chartRoute model

        Models.NoRouteFound ->
            NoRouteFound.notFoundView


getListOfApps : Cmd Msg
getListOfApps =
    let
        url =
            "https://jsonplaceholder.typicode.com/posts/1"

        request = Http.get url decodeUrl

    in
        Http.send Msgs.ListOfApps request

decodeUrl : Decoder String
decodeUrl =
  at ["title"] string

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Msgs.NoOp ->
            ( model, Cmd.none )

        Msgs.DateChanged state value ->
            ( { model | startDateValue = value, startDatePickerState = state }, Cmd.none )

        Msgs.EndDateChanged state value ->
            ( { model | endDateValue = value, endDatePickerState = state }, Cmd.none )

        Msgs.Submit ->
            ( { model | submitted = True }, Cmd.none )

        Msgs.OnData res ->
            ( { model | reviewData = res, inError = False }, Cmd.none )

        Msgs.OnFormError ->
            ( { model | inError = True }, Cmd.none )

        Msgs.OnFormSuccess ->
            ( { model | inError = False }, Cmd.none )

        Msgs.OnLocationChange location ->
            let
                newRoute =
                    parseLocation location
            in
            ( { model | route = newRoute }, Cmd.none )

        Msgs.NewURL location ->
            ( model, Navigation.newUrl location)

        Msgs.ListApps ->
            (model, getListOfApps)

        Msgs.ListOfApps (Ok data) ->
            ( { model | listOfApps = data }
                |> update (Msgs.NewURL "#chart") )

        Msgs.ListOfApps (Err _) ->
            (model, Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions model = Sub.none

main : Program Never Model Msg
main =
    Navigation.program Msgs.OnLocationChange
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }