module Msgs exposing (..)
import Navigation exposing (Location)

import DateTimePicker
import Date exposing (Date)
import Http exposing (Error)


type Msg = NoOp
    | DateChanged DateTimePicker.State (Maybe Date)
    | EndDateChanged DateTimePicker.State (Maybe Date)
    | Submit
    | OnData String
    | OnFormError
    | OnFormSuccess
    | OnLocationChange Location
    | NewURL String

    | ListApps
    | ListOfApps (Result Error String)