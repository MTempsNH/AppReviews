module AppReviews exposing (..)

import Html exposing (Html, button, label, div, form, text, p, program)
import Html.Events exposing (onClick)
import DemoCss exposing (CssClasses(..))
import Css
import DateTimePicker.Css
import Html.CssHelpers

import Date exposing (Date)
import DateTimePicker


type alias Model = {
    startDateValue: Maybe Date,
    startDatePickerState : DateTimePicker.State,
    endDateValue : Maybe Date,
    endDatePickerState : DateTimePicker.State,
    submitted : Bool
    }

init : (Model, Cmd Msg)
init =
    ({
    startDateValue = Nothing,
    startDatePickerState = DateTimePicker.initialState,
    endDateValue = Nothing,
    endDatePickerState = DateTimePicker.initialState,
    submitted = False
      }, Cmd.batch
                 [ DateTimePicker.initialCmd DateChanged DateTimePicker.initialState,
                  DateTimePicker.initialCmd EndDateChanged DateTimePicker.initialState ]
             )


type Msg = NoOp
    | DateChanged DateTimePicker.State (Maybe Date)
    | EndDateChanged DateTimePicker.State (Maybe Date)
    | Submit

view : Model -> Html Msg
view model =
    let
            { css } =
                Css.compile [ DateTimePicker.Css.css ]
    in
        div [] [ form []
            [ Html.node "style" [] [ Html.text css ]
                        , div [ class [ Container ] ]
                [ p
                    []
                    [ label []
                        [ text "Start Date Picker: "
                        , DateTimePicker.datePicker
                            DateChanged
                            []
                            model.startDatePickerState
                            model.startDateValue
                        ]
                    ]

                ],
                div [] [ p
                           []
                           [ label []
                               [ text "End Date Picker: "
                               , DateTimePicker.datePicker
                                   EndDateChanged
                                   []
                                   model.endDatePickerState
                                   model.endDateValue
                               ]
                           ]

                       ]
            ],
            div [] [ button [ onClick Submit ] [ text "Run Reports" ],

            if model.submitted then
                div [] [ text "Submitted" ]
            else
                div [] [ text "Not Submitted Yet" ]]
        ]



update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        DateChanged state value ->
            ( { model | startDateValue = value, startDatePickerState = state }, Cmd.none )

        EndDateChanged state value ->
            ( { model | endDateValue = value, endDatePickerState = state }, Cmd.none )

        Submit ->
            ( { model | submitted = True }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model = Sub.none

{ id, class, classList } =
    Html.CssHelpers.withNamespace ""

main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }