module Main exposing (..)

import Browser
import Html exposing (Html, div, button)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)
import Array exposing (Array, initialize, set)

-- MODEL

type alias Model =
    { pixels : Array Int
    }

init : Model
init =
    { pixels = initialize 9 (\_ -> 0)
    }

-- UPDATE

type Msg
    = ClickedPixel Int

update : Msg -> Model -> Model
update msg model =
    case msg of
        ClickedPixel index ->
            { model | pixels = set index 2 model.pixels }

-- VIEW

view : Model -> Html Msg
view model =
    div [ style "display" "flex"
        , style "flex-direction" "column"
        , style "justify-content" "center"
        , style "align-items" "center"
        , style "height" "100vh"
        ]
        [ div [ style "display" "grid"
               , style "grid-template-columns" "repeat(3, 50px)"
               , style "grid-gap" "5px"
               --, style "margin" "auto"
               ]
               (List.indexedMap (\index color -> pixelView index color) (Array.toList model.pixels))
        ]


pixelView : Int -> Int -> Html Msg
pixelView index color =
    div
        [ style "width" "50px"
        , style "height" "50px"
        , style "border" "1px solid #ccc"
        , style "background-color" (colorToCss color)
        , style "cursor" "pointer"
        , onClick (ClickedPixel index)
        ]
        []

colorToCss : Int -> String
colorToCss color =
    case color of
        0 -> "#ffffff"
        1 -> "#ff0000"
        2 -> "#0000ff"
        _ -> "#ffffff"

-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none

-- MAIN

main =
    Browser.sandbox { init = init, update = update, view = view }
