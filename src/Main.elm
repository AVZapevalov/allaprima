module Main exposing (..)

import Browser
import Html exposing (Html, div, button)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)
import Array exposing (Array, initialize, set)

-- MODEL

type alias Model =
    { pixels : Array Int
    , selectedColor : Int
    }

init : Model
init =
    { pixels = initialize 225 (\_ -> 0)
    , selectedColor = 1
    }

-- UPDATE

type Msg
    = ClickedPixel Int
    | ChangeColor Int
    | ClearCanvas

update : Msg -> Model -> Model
update msg model =
    case msg of
        ClickedPixel index ->
            { model | pixels = set index model.selectedColor model.pixels }

        ChangeColor color ->
            { model | selectedColor = color }
        
        ClearCanvas ->
            { model | pixels = initialize 225 (\_ -> 0) }

-- VIEW

view : Model -> Html Msg
view model =
    div [ style "background-color" "#F5F5DC"
        , style "display" "flex"
        , style "flex-direction" "column"
        , style "justify-content" "center"
        , style "align-items" "center"
        , style "height" "100vh"
        ]
        [ div [ style "display" "grid"
               , style "grid-template-columns" "repeat(15, 30px)"
               ]
               (List.indexedMap (\index color -> pixelView index color) (Array.toList model.pixels))
        , paletteView model.selectedColor
        , button [ onClick ClearCanvas, style "margin-top" "10px" ] [ Html.text "Очистить рисунок" ]
        ]
        

paletteView : Int -> Html Msg
paletteView selectedColor =
    div [ style "display" "flex"
        , style "margin-top" "10px"
        ]
        (List.map (\color -> colorButtonView color selectedColor) [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15])

colorButtonView : Int -> Int -> Html Msg
colorButtonView color selectedColor =
    div
        [ style "width" "20px"
        , style "height" "20px"
        , style "margin-right" "2px"
        , style "background-color" (colorToCss color)
        , style "cursor" "pointer"
        , style "border" ("1px solid " ++ if color == selectedColor then "#000" else "#fff")
        , onClick (ChangeColor color)
        ]
        []


pixelView : Int -> Int -> Html Msg
pixelView index color =
    div
        [ style "width" "30px"
        , style "height" "30px"
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
        1 -> "#ff0000" -- Красный
        2 -> "#0000ff" -- Синий
        3 -> "#00ff00" -- Зеленый
        4 -> "#ffff00" -- Желтый
        5 -> "#000000" -- Черный
        6 -> "#00ffff" -- Голубой
        7 -> "#008000" -- Темнозеленый
        8 -> "#ffA500" -- Оранжевый
        9 -> "#FFC0CB" -- Розовый
        10 -> "#800080" -- Фиолетовый
        11 -> "#808080" -- Серый
        12 -> "#ffffff" -- Белый
        13 -> "#008080" -- Изумрудный
        14 -> "#8B4513" -- Коричневый
        15 -> "#FFD700" -- Золотой
        _ -> "#ffffff"

-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none

-- MAIN

main =
    Browser.sandbox { init = init, update = update, view = view }
