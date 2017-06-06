module AppReviews exposing (..)

import Html exposing (Html, label, div, form, text, p, program)
import DemoCss exposing (CssClasses(..))
import Css
import DateTimePicker.Css
import Html.CssHelpers

import Date exposing (Date)
import DateTimePicker


type alias Model = {
    dateValue: Maybe Date
    , datePickerState : DateTimePicker.State}

init : (Model, Cmd Msg)
init =
    ({ dateValue = Nothing
      , datePickerState = DateTimePicker.initialState
      }, Cmd.batch
                 [ DateTimePicker.initialCmd DateChanged DateTimePicker.initialState ]
             )


type Msg = NoOp
    | DateChanged DateTimePicker.State (Maybe Date)

view : Model -> Html Msg
view model =
    let
            { css } =
                Css.compile [ DateTimePicker.Css.css ]
    in
        form []
            [ Html.node "style" [] [ Html.text css ]
                        , div [ class [ Container ] ]
                [ p
                    []
                    [ label []
                        [ text "Date Picker: "
                        , DateTimePicker.datePicker
                            DateChanged
                            []
                            model.datePickerState
                            model.dateValue
                        ]
                    ]
                ]
            ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        DateChanged state value ->
                    ( { model | dateValue = value, datePickerState = state }, Cmd.none )

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