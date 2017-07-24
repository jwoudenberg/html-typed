module Layout exposing (Layout, col, col2, h1, h2, p, section, text, view)

import Html exposing (Html)
import Html.Attributes as Attr
import Semantic.Internal as Semantic exposing (Attrs)


type Layout msg
    = TextNode String
    | Wrapper Element (Attrs msg) (Layout msg)
    | Column (List (Layout msg))


type Element
    = H1
    | H2
    | Section
    | P



{- Layout functions

   All primitive types have a function here, plus functions to position types with regards to one another.
-}


p : (child -> Layout msg) -> Semantic.P child msg -> Layout msg
p layoutChild (Semantic.P attrs child) =
    Wrapper P attrs (layoutChild child)


h1 : (child -> Layout msg) -> Semantic.H1 child msg -> Layout msg
h1 layoutChild (Semantic.H1 attrs child) =
    Wrapper H1 attrs (layoutChild child)


h2 : (child -> Layout msg) -> Semantic.H2 child msg -> Layout msg
h2 layoutChild (Semantic.H2 attrs child) =
    Wrapper H2 attrs (layoutChild child)


section : (child -> Layout msg) -> Semantic.Section child msg -> Layout msg
section layoutChild (Semantic.Section attrs child) =
    Wrapper Section attrs (layoutChild child)


text : String -> Layout msg
text =
    TextNode


col2 : (a -> Layout msg) -> (b -> Layout msg) -> ( a, b ) -> Layout msg
col2 layoutA layoutB ( a, b ) =
    Column
        [ layoutA a
        , layoutB b
        ]


col : (a -> Layout msg) -> List a -> Layout msg
col layoutRow rows =
    Column (List.map layoutRow rows)


view : Layout msg -> Html msg
view layout =
    case layout of
        TextNode text ->
            Html.text text

        Wrapper element attrs child ->
            nodeFor element attrs [ view child ]

        Column children ->
            Html.div
                [ Attr.style
                    [ ( "display", "flex" )
                    , ( "flex-direction", "column" )
                    ]
                ]
                (List.map view children)



-- | Column (List (Layout msg))


nodeFor : Element -> (Attrs msg -> List (Html msg) -> Html msg)
nodeFor element =
    case element of
        H1 ->
            Html.h1

        H2 ->
            Html.h2

        Section ->
            Html.section

        P ->
            Html.p
