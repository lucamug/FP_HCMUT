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
    , positionY : Float
    , direction : Direction
    , state : State
    , aliens : List ( Float, Float )
    }


init : ( Model, Cmd msg )
init =
    ( { count = 0
      , positionX = 0
      , positionY = 0
      , direction = Right
      , state = Playing
      , aliens = []
      }
    , Cmd.none
    )


type Msg
    = Increment
    | Decrement
    | OnAnimationFrame Float
    | TogglePause


speedX : Float
speedX =
    5


speedY : Float
speedY =
    2


speedAlien : Float
speedAlien =
    4


update : Msg -> Model -> ( Model, Cmd msg )
update msg model =
    case msg of
        Increment ->
            ( { model | count = model.count + 1 }, Cmd.none )

        Decrement ->
            ( { model
                | aliens = ( model.positionX, model.positionY ) :: model.aliens
              }
            , Cmd.none
            )

        OnAnimationFrame delta ->
            ( { model
                | positionX =
                    case model.direction of
                        Left ->
                            model.positionX - speedX

                        Right ->
                            model.positionX + speedX
                , positionY =
                    if model.positionX > 270 || model.positionX < 0 then
                        model.positionY + speedY

                    else
                        model.positionY
                , direction =
                    if model.positionX > 270 then
                        Left

                    else if model.positionX < 0 then
                        Right

                    else
                        model.direction
                , aliens =
                    List.map
                        (\( alienX, alienY ) -> ( alienX, alienY + speedAlien ))
                        model.aliens
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
        column
            ([ spacing 20
             ]
                ++ List.map
                    (\( alienX, alienY ) ->
                        inFront <|
                            el
                                [ Font.size 30
                                , moveRight alienX
                                , moveDown (alienY + 100)
                                ]
                            <|
                                text "👽"
                    )
                    model.aliens
            )
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
                , moveDown model.positionY
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
