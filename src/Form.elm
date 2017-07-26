module Form exposing (..)

import Html exposing (Html, a, button, label, div, form, text, p, program)
import Html.Attributes exposing (href)
import Debug exposing (log)

import DemoCss exposing (CssClasses(..))
import Css
import DateTimePicker.Css
import Html.CssHelpers

import Html.Events exposing (onClick)

import Date exposing (Date)
import DateTimePicker
import Date.Extra.Format exposing ( isoDateString )

import ReadData

import Models exposing (Model)
import Msgs exposing (Msg)

import Navigation exposing (newUrl)

{ id, class, classList } =
    Html.CssHelpers.withNamespace ""

type Link = Cmd Msg | Msg

myOnClickHandler: Maybe Date -> Maybe Date -> Msg
myOnClickHandler start end =
    case start of
    Nothing ->
        log "date is null"
        Msgs.OnFormError

    Just date ->
        let
            dateStr = isoDateString date
        in
            log dateStr
            Msgs.OnData ReadData.get

myLinkHandler: String -> Msg
myLinkHandler destination =
    let
        dest = destination
    in
        case dest of
        "#chart" ->
            Msgs.NewURL dest

        _ ->
           Msgs.NewURL dest

formView : Model -> Html Msg
formView model =
    let
        { css } =
            Css.compile [ DateTimePicker.Css.css ]
    in
        div [] [
        if model.inError then
            p [] [ text "Please enter a start and end date" ]
        else
            p [] [],

        div [] [ form []
            [ Html.node "style" [] [ Html.text css ]
                        , div [ class [ FormContainer ] ]
                [ p
                    []
                    [ label []
                        [ text "Start Date Picker: "
                        , DateTimePicker.datePicker
                            Msgs.DateChanged
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
                                   Msgs.EndDateChanged
                                   []
                                   model.endDatePickerState
                                   model.endDateValue
                               ]
                           ]

                       ]
            ],

            div [] [ button [ onClick (myOnClickHandler model.startDateValue model.endDateValue) ] [ text "Run Reports" ],

            if model.submitted then
                div [] [ text "Submitted" ]
            else

                -- div [] [ text model.reviewData ],
                div [] [ a [ onClick (myLinkHandler "#chart") ] [ text "Continue" ]],
                div [] [ a [ onClick (myLinkHandler "#pause") ] [ text "Pause" ]]
            ]
        ]
    ]