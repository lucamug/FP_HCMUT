module Main exposing (main)

import Browser
import Browser.Events
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Html
import Html.Attributes



-- 💥 🪐 👽 ▶️ ⏸️ 🛸


type State
    = Playing
    | Over
    | Paused


type Direction
    = Left
    | Right


type alias Model =
    { count : Int
    , positionX : Float
    , direction : Direction
    , state : State
    }


init : ( Model, Cmd msg )
init =
    ( { count = 0
      , positionX = 0
      , direction = Right
      , state = Playing
      }
    , Cmd.none
    )


type Msg
    = Increment
    | Decrement
    | OnAnimationFrame Float
    | TogglePause


update : Msg -> Model -> ( Model, Cmd msg )
update msg model =
    case msg of
        Increment ->
            ( { model | count = model.count + 1 }, Cmd.none )

        Decrement ->
            ( { model | count = model.count - 1 }, Cmd.none )

        OnAnimationFrame delta ->
            ( { model
                | positionX =
                    case model.direction of
                        Left ->
                            model.positionX - 5

                        Right ->
                            model.positionX + 5
                , direction =
                    if model.positionX > 270 then
                        Left

                    else if model.positionX < 0 then
                        Right

                    else
                        model.direction
              }
            , Cmd.none
            )

        TogglePause ->
            ( { model
                | state =
                    case model.state of
                        Playing ->
                            Paused

                        Over ->
                            Over

                        Paused ->
                            Playing
              }
            , Cmd.none
            )


attrsButton : List (Attribute msg)
attrsButton =
    [ Border.width 1
    , padding 10
    , Border.rounded 10
    , Background.color <| rgb 1 1 1
    ]


view : Model -> Html.Html Msg
view model =
    layout [ padding 20, Background.color <| rgb 0 0.4 0.6 ] <|
        column [ spacing 20 ]
            [ Input.button attrsButton
                { onPress = Just TogglePause
                , label =
                    text <|
                        case model.state of
                            Playing ->
                                "⏸️"

                            Over ->
                                ""

                            Paused ->
                                "▶️"
                }
            , Input.button
                [ moveRight model.positionX
                , Font.size 100
                , case model.direction of
                    Left ->
                        rotate 0

                    Right ->
                        rotate 0.6
                , htmlAttribute <| Html.Attributes.style "transition" "transform 100ms"
                ]
                { onPress = Just Increment, label = text "🛸" }
            , text <| String.fromInt model.count
            , Input.button attrsButton { onPress = Just Decrement, label = text "Decrement" }
            ]


main : Program () Model Msg
main =
    Browser.element
        { init = \_ -> init
        , view = view
        , update = update
        , subscriptions =
            \model ->
                case model.state of
                    Playing ->
                        Browser.Events.onAnimationFrameDelta OnAnimationFrame

                    Over ->
                        Sub.none

                    Paused ->
                        Sub.none
        }
