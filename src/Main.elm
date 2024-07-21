module Main exposing (main)

import Browser
import Browser.Events
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Html


type Direction
    = Left
    | Right


type alias Model =
    { count : Int
    , positionX : Float
    , direction : Direction
    }


init : ( Model, Cmd msg )
init =
    ( { count = 0
      , positionX = 0
      , direction = Right
      }
    , Cmd.none
    )


type Msg
    = Increment
    | Decrement
    | OnAnimationFrame Float


update : Msg -> Model -> ( Model, Cmd msg )
update msg model =
    case msg of
        Increment ->
            ( { model | count = model.count + 1 }, Cmd.none )

        Decrement ->
            ( { model | count = model.count - 1 }, Cmd.none )

        OnAnimationFrame delta ->
            case model.direction of
                Left ->
                    if model.positionX < 0 then
                        ( { model
                            | positionX = model.positionX + 5
                            , direction = Right
                          }
                        , Cmd.none
                        )

                    else
                        ( { model
                            | positionX = model.positionX - 5
                          }
                        , Cmd.none
                        )

                Right ->
                    if model.positionX > 300 then
                        ( { model
                            | positionX = model.positionX - 5
                            , direction = Left
                          }
                        , Cmd.none
                        )

                    else
                        ( { model
                            | positionX = model.positionX + 5
                          }
                        , Cmd.none
                        )


attrsButton : List (Attribute msg)
attrsButton =
    [ Border.width 1
    , padding 10
    , Border.rounded 10
    ]


view : Model -> Html.Html Msg
view model =
    layout [ padding 20 ] <|
        column [ spacing 20 ]
            [ Input.button (attrsButton ++ [ moveRight model.positionX ]) { onPress = Just Increment, label = text "Increment" }
            , text <| String.fromInt model.count
            , Input.button attrsButton { onPress = Just Decrement, label = text "Decrement" }
            ]


main : Program () Model Msg
main =
    Browser.element
        { init = \_ -> init
        , view = view
        , update = update
        , subscriptions = \_ -> Browser.Events.onAnimationFrameDelta OnAnimationFrame
        }
