module Models exposing (..)

import DateTimePicker
import Date exposing (Date)

type alias Model = {
    startDateValue: Maybe Date,
    startDatePickerState : DateTimePicker.State,
    endDateValue : Maybe Date,
    endDatePickerState : DateTimePicker.State,
    listOfApps : String,
    submitted : Bool,
    reviewData : String,
    inError : Bool,
    route : Route
    }

type Route
    = HomeRoute
    | ChartRoute
    | NoRouteFound