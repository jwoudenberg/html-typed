module Html.Typed exposing (Attribute, Html, a, abbr, add, address, article, aside, audio, b, bdi, bdo, body, br, button, canvas, caption, cite, code, col, colgroup, datalist, dd, debug, del, detail, dfn, div, dl, em, embed, fieldset, figcaption, figure, footer, form, fromRaw, h1, h2, h3, h4, h5, h6, header, hr, i, iframe, img, input, ins, kbd, keygen, label, legend, li, list, main_, map, mark, math, menu, menuitem, meter, name, nav, object, ol, optgroup, option, output, p, param, pre, progress, q, rp, rt, ruby, s, samp, section, select, small, source, span, strong, sub, summary, sup, table, tbody, td, text, textarea, tfoot, th, thead, time, toRaw, tr, track, u, ul, var, video, wbr, within)

import Html
import Html.Typed.Internal exposing (SubAttribute, mapAttr, mkAttr, toSubAttr)
import Html.Typed.Types exposing (..)


type alias Attribute attrs msg =
    Html.Typed.Internal.Attribute attrs msg



-- # Single type representation
-- This is meant for creating view functions.
-- 1. A phantom type ensures the Html corresponds to the page type.
-- 2. We don't render directly into Html to support different interpreters:
--    - Elm-css uses a different Html type.
--    - A view test might wish to interpret the view in a different way.
--    - Certain optimizations (like collapsing unnecessary containers) are only
--      possible if we can introspect our page structure.


type Html tipe msg
    = Html (SubHtml msg)


type SubHtml msg
    = Node String (List (SubAttribute msg)) (SubHtml msg)
    | Text String
    | List (List (SubHtml msg))
    | Raw (Html.Html msg)


toSubHtml : Html tipe msg -> SubHtml msg
toSubHtml (Html subHtml) =
    subHtml


h1 : List (Attribute attrs msg) -> Html tipe msg -> Html (H1 attrs tipe) msg
h1 attrs child =
    Html <| Node "h1" (List.map toSubAttr attrs) (toSubHtml child)


h2 : List (Attribute attrs msg) -> Html tipe msg -> Html (H2 attrs tipe) msg
h2 attrs child =
    Html <| Node "h2" (List.map toSubAttr attrs) (toSubHtml child)


h3 : List (Attribute attrs msg) -> Html tipe msg -> Html (H3 attrs tipe) msg
h3 attrs child =
    Html <| Node "h3" (List.map toSubAttr attrs) (toSubHtml child)


h4 : List (Attribute attrs msg) -> Html tipe msg -> Html (H4 attrs tipe) msg
h4 attrs child =
    Html <| Node "h4" (List.map toSubAttr attrs) (toSubHtml child)


h5 : List (Attribute attrs msg) -> Html tipe msg -> Html (H5 attrs tipe) msg
h5 attrs child =
    Html <| Node "h5" (List.map toSubAttr attrs) (toSubHtml child)


h6 : List (Attribute attrs msg) -> Html tipe msg -> Html (H6 attrs tipe) msg
h6 attrs child =
    Html <| Node "h6" (List.map toSubAttr attrs) (toSubHtml child)


{-| Represents a generic container with no special meaning.

Divs are assumed to be wrappers that do not affect the semantics of the page,
and so they take the same type as the element that they wrap. Put differently:
adding extra divs in your views will not affect compilation.

-}
section : List (Attribute attrs msg) -> Html tipe msg -> Html (Section attrs tipe) msg
section attrs child =
    Html <| Node "section" (List.map toSubAttr attrs) (toSubHtml child)


p : List (Attribute attrs msg) -> Html tipe msg -> Html (P attrs tipe) msg
p attrs child =
    Html <| Node "p" (List.map toSubAttr attrs) (toSubHtml child)


text : String -> Html String msg
text text =
    Html <| Text text


div : List (Attribute attrs msg) -> Html tipe msg -> Html tipe msg
div attrs child =
    Html <| Node "div" (List.map toSubAttr attrs) (toSubHtml child)


hr : List (Attribute attrs msg) -> Html tipe msg -> Html (Hr attrs tipe) msg
hr attrs child =
    Html <| Node "hr" (List.map toSubAttr attrs) (toSubHtml child)


pre : List (Attribute attrs msg) -> Html tipe msg -> Html (Pre attrs tipe) msg
pre attrs child =
    Html <| Node "pre" (List.map toSubAttr attrs) (toSubHtml child)


blockquote : List (Attribute attrs msg) -> Html tipe msg -> Html (Blockquote attrs tipe) msg
blockquote attrs child =
    Html <| Node "blockquote" (List.map toSubAttr attrs) (toSubHtml child)


span : List (Attribute attrs msg) -> Html tipe msg -> Html tipe msg
span attrs child =
    Html <| Node "span" (List.map toSubAttr attrs) (toSubHtml child)


{-| Represents text with no specific meaning.

Spans are assumed to be wrappers that do not affect the semantics of the page,
and so they take the same type as the element that they wrap. Put differently:
adding extra span in your views will not affect compilation.

-}
a : List (Attribute attrs msg) -> Html tipe msg -> Html (A attrs tipe) msg
a attrs child =
    Html <| Node "a" (List.map toSubAttr attrs) (toSubHtml child)


code : List (Attribute attrs msg) -> Html tipe msg -> Html (Code attrs tipe) msg
code attrs child =
    Html <| Node "code" (List.map toSubAttr attrs) (toSubHtml child)


em : List (Attribute attrs msg) -> Html tipe msg -> Html (Em attrs tipe) msg
em attrs child =
    Html <| Node "em" (List.map toSubAttr attrs) (toSubHtml child)


strong : List (Attribute attrs msg) -> Html tipe msg -> Html (Strong attrs tipe) msg
strong attrs child =
    Html <| Node "strong" (List.map toSubAttr attrs) (toSubHtml child)


i : List (Attribute attrs msg) -> Html tipe msg -> Html (I attrs tipe) msg
i attrs child =
    Html <| Node "i" (List.map toSubAttr attrs) (toSubHtml child)


b : List (Attribute attrs msg) -> Html tipe msg -> Html (B attrs tipe) msg
b attrs child =
    Html <| Node "b" (List.map toSubAttr attrs) (toSubHtml child)


u : List (Attribute attrs msg) -> Html tipe msg -> Html (U attrs tipe) msg
u attrs child =
    Html <| Node "u" (List.map toSubAttr attrs) (toSubHtml child)


sub : List (Attribute attrs msg) -> Html tipe msg -> Html (Html.Typed.Types.Sub attrs tipe) msg
sub attrs child =
    Html <| Node "sub" (List.map toSubAttr attrs) (toSubHtml child)


sup : List (Attribute attrs msg) -> Html tipe msg -> Html (Sup attrs tipe) msg
sup attrs child =
    Html <| Node "sup" (List.map toSubAttr attrs) (toSubHtml child)


br : List (Attribute attrs msg) -> Html tipe msg -> Html (Br attrs tipe) msg
br attrs child =
    Html <| Node "br" (List.map toSubAttr attrs) (toSubHtml child)


ol : List (Attribute attrs msg) -> Html tipe msg -> Html (Ol attrs tipe) msg
ol attrs child =
    Html <| Node "ol" (List.map toSubAttr attrs) (toSubHtml child)


ul : List (Attribute attrs msg) -> Html tipe msg -> Html (Ul attrs tipe) msg
ul attrs child =
    Html <| Node "ul" (List.map toSubAttr attrs) (toSubHtml child)


li : List (Attribute attrs msg) -> Html tipe msg -> Html (Li attrs tipe) msg
li attrs child =
    Html <| Node "li" (List.map toSubAttr attrs) (toSubHtml child)


dl : List (Attribute attrs msg) -> Html tipe msg -> Html (Dl attrs tipe) msg
dl attrs child =
    Html <| Node "dl" (List.map toSubAttr attrs) (toSubHtml child)


dd : List (Attribute attrs msg) -> Html tipe msg -> Html (Dd attrs tipe) msg
dd attrs child =
    Html <| Node "dd" (List.map toSubAttr attrs) (toSubHtml child)


img : List (Attribute attrs msg) -> Html tipe msg -> Html (Img attrs tipe) msg
img attrs child =
    Html <| Node "img" (List.map toSubAttr attrs) (toSubHtml child)


iframe : List (Attribute attrs msg) -> Html tipe msg -> Html (Iframe attrs tipe) msg
iframe attrs child =
    Html <| Node "iframe" (List.map toSubAttr attrs) (toSubHtml child)


canvas : List (Attribute attrs msg) -> Html tipe msg -> Html (Canvas attrs tipe) msg
canvas attrs child =
    Html <| Node "canvas" (List.map toSubAttr attrs) (toSubHtml child)


math : List (Attribute attrs msg) -> Html tipe msg -> Html (Math attrs tipe) msg
math attrs child =
    Html <| Node "math" (List.map toSubAttr attrs) (toSubHtml child)


form : List (Attribute attrs msg) -> Html tipe msg -> Html (Form attrs tipe) msg
form attrs child =
    Html <| Node "form" (List.map toSubAttr attrs) (toSubHtml child)


input : List (Attribute attrs msg) -> Html tipe msg -> Html (Input attrs tipe) msg
input attrs child =
    Html <| Node "input" (List.map toSubAttr attrs) (toSubHtml child)


textarea : List (Attribute attrs msg) -> Html tipe msg -> Html (Textarea attrs tipe) msg
textarea attrs child =
    Html <| Node "textarea" (List.map toSubAttr attrs) (toSubHtml child)


button : List (Attribute attrs msg) -> Html tipe msg -> Html (Button attrs tipe) msg
button attrs child =
    Html <| Node "button" (List.map toSubAttr attrs) (toSubHtml child)


select : List (Attribute attrs msg) -> Html tipe msg -> Html (Select attrs tipe) msg
select attrs child =
    Html <| Node "select" (List.map toSubAttr attrs) (toSubHtml child)


option : List (Attribute attrs msg) -> Html tipe msg -> Html (Option attrs tipe) msg
option attrs child =
    Html <| Node "option" (List.map toSubAttr attrs) (toSubHtml child)


nav : List (Attribute attrs msg) -> Html tipe msg -> Html (Nav attrs tipe) msg
nav attrs child =
    Html <| Node "nav" (List.map toSubAttr attrs) (toSubHtml child)


article : List (Attribute attrs msg) -> Html tipe msg -> Html (Article attrs tipe) msg
article attrs child =
    Html <| Node "article" (List.map toSubAttr attrs) (toSubHtml child)


aside : List (Attribute attrs msg) -> Html tipe msg -> Html (Aside attrs tipe) msg
aside attrs child =
    Html <| Node "aside" (List.map toSubAttr attrs) (toSubHtml child)


header : List (Attribute attrs msg) -> Html tipe msg -> Html (Header attrs tipe) msg
header attrs child =
    Html <| Node "header" (List.map toSubAttr attrs) (toSubHtml child)


footer : List (Attribute attrs msg) -> Html tipe msg -> Html (Footer attrs tipe) msg
footer attrs child =
    Html <| Node "footer" (List.map toSubAttr attrs) (toSubHtml child)


address : List (Attribute attrs msg) -> Html tipe msg -> Html (Address attrs tipe) msg
address attrs child =
    Html <| Node "address" (List.map toSubAttr attrs) (toSubHtml child)


main_ : List (Attribute attrs msg) -> Html tipe msg -> Html (Main attrs tipe) msg
main_ attrs child =
    Html <| Node "main" (List.map toSubAttr attrs) (toSubHtml child)


body : List (Attribute attrs msg) -> Html tipe msg -> Html (Body attrs tipe) msg
body attrs child =
    Html <| Node "body" (List.map toSubAttr attrs) (toSubHtml child)


figure : List (Attribute attrs msg) -> Html tipe msg -> Html (Figure attrs tipe) msg
figure attrs child =
    Html <| Node "figure" (List.map toSubAttr attrs) (toSubHtml child)


figcaption : List (Attribute attrs msg) -> Html tipe msg -> Html (Figcaption attrs tipe) msg
figcaption attrs child =
    Html <| Node "figcaption" (List.map toSubAttr attrs) (toSubHtml child)


table : List (Attribute attrs msg) -> Html tipe msg -> Html (Table attrs tipe) msg
table attrs child =
    Html <| Node "table" (List.map toSubAttr attrs) (toSubHtml child)


caption : List (Attribute attrs msg) -> Html tipe msg -> Html (Caption attrs tipe) msg
caption attrs child =
    Html <| Node "caption" (List.map toSubAttr attrs) (toSubHtml child)


colgroup : List (Attribute attrs msg) -> Html tipe msg -> Html (Colgroup attrs tipe) msg
colgroup attrs child =
    Html <| Node "colgroup" (List.map toSubAttr attrs) (toSubHtml child)


col : List (Attribute attrs msg) -> Html tipe msg -> Html (Col attrs tipe) msg
col attrs child =
    Html <| Node "col" (List.map toSubAttr attrs) (toSubHtml child)


tbody : List (Attribute attrs msg) -> Html tipe msg -> Html (Tbody attrs tipe) msg
tbody attrs child =
    Html <| Node "tbody" (List.map toSubAttr attrs) (toSubHtml child)


thead : List (Attribute attrs msg) -> Html tipe msg -> Html (Thead attrs tipe) msg
thead attrs child =
    Html <| Node "thead" (List.map toSubAttr attrs) (toSubHtml child)


tfoot : List (Attribute attrs msg) -> Html tipe msg -> Html (Tfoot attrs tipe) msg
tfoot attrs child =
    Html <| Node "tfoot" (List.map toSubAttr attrs) (toSubHtml child)


tr : List (Attribute attrs msg) -> Html tipe msg -> Html (Tr attrs tipe) msg
tr attrs child =
    Html <| Node "tr" (List.map toSubAttr attrs) (toSubHtml child)


td : List (Attribute attrs msg) -> Html tipe msg -> Html (Td attrs tipe) msg
td attrs child =
    Html <| Node "td" (List.map toSubAttr attrs) (toSubHtml child)


th : List (Attribute attrs msg) -> Html tipe msg -> Html (Th attrs tipe) msg
th attrs child =
    Html <| Node "th" (List.map toSubAttr attrs) (toSubHtml child)


fieldset : List (Attribute attrs msg) -> Html tipe msg -> Html (Fieldset attrs tipe) msg
fieldset attrs child =
    Html <| Node "fieldset" (List.map toSubAttr attrs) (toSubHtml child)


legend : List (Attribute attrs msg) -> Html tipe msg -> Html (Legend attrs tipe) msg
legend attrs child =
    Html <| Node "legend" (List.map toSubAttr attrs) (toSubHtml child)


label : List (Attribute attrs msg) -> Html tipe msg -> Html (Label attrs tipe) msg
label attrs child =
    Html <| Node "label" (List.map toSubAttr attrs) (toSubHtml child)


datalist : List (Attribute attrs msg) -> Html tipe msg -> Html (Datalist attrs tipe) msg
datalist attrs child =
    Html <| Node "datalist" (List.map toSubAttr attrs) (toSubHtml child)


optgroup : List (Attribute attrs msg) -> Html tipe msg -> Html (Optgroup attrs tipe) msg
optgroup attrs child =
    Html <| Node "optgroup" (List.map toSubAttr attrs) (toSubHtml child)


keygen : List (Attribute attrs msg) -> Html tipe msg -> Html (Keygen attrs tipe) msg
keygen attrs child =
    Html <| Node "keygen" (List.map toSubAttr attrs) (toSubHtml child)


output : List (Attribute attrs msg) -> Html tipe msg -> Html (Output attrs tipe) msg
output attrs child =
    Html <| Node "output" (List.map toSubAttr attrs) (toSubHtml child)


progress : List (Attribute attrs msg) -> Html tipe msg -> Html (Progress attrs tipe) msg
progress attrs child =
    Html <| Node "progress" (List.map toSubAttr attrs) (toSubHtml child)


meter : List (Attribute attrs msg) -> Html tipe msg -> Html (Meter attrs tipe) msg
meter attrs child =
    Html <| Node "meter" (List.map toSubAttr attrs) (toSubHtml child)


audio : List (Attribute attrs msg) -> Html tipe msg -> Html (Audio attrs tipe) msg
audio attrs child =
    Html <| Node "audio" (List.map toSubAttr attrs) (toSubHtml child)


video : List (Attribute attrs msg) -> Html tipe msg -> Html (Video attrs tipe) msg
video attrs child =
    Html <| Node "video" (List.map toSubAttr attrs) (toSubHtml child)


source : List (Attribute attrs msg) -> Html tipe msg -> Html (Source attrs tipe) msg
source attrs child =
    Html <| Node "source" (List.map toSubAttr attrs) (toSubHtml child)


track : List (Attribute attrs msg) -> Html tipe msg -> Html (Track attrs tipe) msg
track attrs child =
    Html <| Node "track" (List.map toSubAttr attrs) (toSubHtml child)


embed : List (Attribute attrs msg) -> Html tipe msg -> Html (Embed attrs tipe) msg
embed attrs child =
    Html <| Node "embed" (List.map toSubAttr attrs) (toSubHtml child)


object : List (Attribute attrs msg) -> Html tipe msg -> Html (Object attrs tipe) msg
object attrs child =
    Html <| Node "object" (List.map toSubAttr attrs) (toSubHtml child)


param : List (Attribute attrs msg) -> Html tipe msg -> Html (Param attrs tipe) msg
param attrs child =
    Html <| Node "param" (List.map toSubAttr attrs) (toSubHtml child)


ins : List (Attribute attrs msg) -> Html tipe msg -> Html (Ins attrs tipe) msg
ins attrs child =
    Html <| Node "ins" (List.map toSubAttr attrs) (toSubHtml child)


del : List (Attribute attrs msg) -> Html tipe msg -> Html (Del attrs tipe) msg
del attrs child =
    Html <| Node "del" (List.map toSubAttr attrs) (toSubHtml child)


small : List (Attribute attrs msg) -> Html tipe msg -> Html (Small attrs tipe) msg
small attrs child =
    Html <| Node "small" (List.map toSubAttr attrs) (toSubHtml child)


cite : List (Attribute attrs msg) -> Html tipe msg -> Html (Cite attrs tipe) msg
cite attrs child =
    Html <| Node "cite" (List.map toSubAttr attrs) (toSubHtml child)


dfn : List (Attribute attrs msg) -> Html tipe msg -> Html (Dfn attrs tipe) msg
dfn attrs child =
    Html <| Node "dfn" (List.map toSubAttr attrs) (toSubHtml child)


abbr : List (Attribute attrs msg) -> Html tipe msg -> Html (Abbr attrs tipe) msg
abbr attrs child =
    Html <| Node "abbr" (List.map toSubAttr attrs) (toSubHtml child)


time : List (Attribute attrs msg) -> Html tipe msg -> Html (Time attrs tipe) msg
time attrs child =
    Html <| Node "time" (List.map toSubAttr attrs) (toSubHtml child)


var : List (Attribute attrs msg) -> Html tipe msg -> Html (Var attrs tipe) msg
var attrs child =
    Html <| Node "var" (List.map toSubAttr attrs) (toSubHtml child)


samp : List (Attribute attrs msg) -> Html tipe msg -> Html (Samp attrs tipe) msg
samp attrs child =
    Html <| Node "samp" (List.map toSubAttr attrs) (toSubHtml child)


kbd : List (Attribute attrs msg) -> Html tipe msg -> Html (Kbd attrs tipe) msg
kbd attrs child =
    Html <| Node "kbd" (List.map toSubAttr attrs) (toSubHtml child)


s : List (Attribute attrs msg) -> Html tipe msg -> Html (S attrs tipe) msg
s attrs child =
    Html <| Node "s" (List.map toSubAttr attrs) (toSubHtml child)


q : List (Attribute attrs msg) -> Html tipe msg -> Html (Q attrs tipe) msg
q attrs child =
    Html <| Node "q" (List.map toSubAttr attrs) (toSubHtml child)


mark : List (Attribute attrs msg) -> Html tipe msg -> Html (Mark attrs tipe) msg
mark attrs child =
    Html <| Node "mark" (List.map toSubAttr attrs) (toSubHtml child)


ruby : List (Attribute attrs msg) -> Html tipe msg -> Html (Ruby attrs tipe) msg
ruby attrs child =
    Html <| Node "ruby" (List.map toSubAttr attrs) (toSubHtml child)


rt : List (Attribute attrs msg) -> Html tipe msg -> Html (Rt attrs tipe) msg
rt attrs child =
    Html <| Node "rt" (List.map toSubAttr attrs) (toSubHtml child)


rp : List (Attribute attrs msg) -> Html tipe msg -> Html (Rp attrs tipe) msg
rp attrs child =
    Html <| Node "rp" (List.map toSubAttr attrs) (toSubHtml child)


bdi : List (Attribute attrs msg) -> Html tipe msg -> Html (Bdi attrs tipe) msg
bdi attrs child =
    Html <| Node "bdi" (List.map toSubAttr attrs) (toSubHtml child)


bdo : List (Attribute attrs msg) -> Html tipe msg -> Html (Bdo attrs tipe) msg
bdo attrs child =
    Html <| Node "bdo" (List.map toSubAttr attrs) (toSubHtml child)


wbr : List (Attribute attrs msg) -> Html tipe msg -> Html (Wbr attrs tipe) msg
wbr attrs child =
    Html <| Node "wbr" (List.map toSubAttr attrs) (toSubHtml child)


detail : List (Attribute attrs msg) -> Html tipe msg -> Html (Detail attrs tipe) msg
detail attrs child =
    Html <| Node "detail" (List.map toSubAttr attrs) (toSubHtml child)


summary : List (Attribute attrs msg) -> Html tipe msg -> Html (Summary attrs tipe) msg
summary attrs child =
    Html <| Node "summary" (List.map toSubAttr attrs) (toSubHtml child)


menuitem : List (Attribute attrs msg) -> Html tipe msg -> Html (Menuitem attrs tipe) msg
menuitem attrs child =
    Html <| Node "menuitem" (List.map toSubAttr attrs) (toSubHtml child)


menu : List (Attribute attrs msg) -> Html tipe msg -> Html (Menu attrs tipe) msg
menu attrs child =
    Html <| Node "menu" (List.map toSubAttr attrs) (toSubHtml child)


list : List (Html tipe msg) -> Html (List tipe) msg
list xs =
    Html <| List (List.map toSubHtml xs)


within : (a -> b) -> Html (a -> b) msg
within _ =
    Html <| List []


add : Html tipe1 msg -> Html (tipe1 -> tipe2) msg -> Html tipe2 msg
add child2 child1 =
    Html <|
        case ( toSubHtml child1, toSubHtml child2 ) of
            ( List xs, List ys ) ->
                List (xs ++ ys)

            ( List xs, y ) ->
                List (xs ++ [ y ])

            ( x, List ys ) ->
                List (x :: ys)

            ( x, y ) ->
                List [ x, y ]


{-| Useful during development, to get unimplemented parts of view functions compiling.
-}
debug : Html tipe msg
debug =
    Html <| Text "Debugging value. Remove me!"


map : (a -> msg) -> Html tipe a -> Html tipe msg
map fn (Html subHtml) =
    Html (mapSubHtml fn subHtml)


{-| Name a view type to have that name appear in compiler errors rather than a
tree of html types.

Suppose your social network app contains a chatbox widget. Ordinarily view
compilation errors of parts of your page that include the widget would contain
the tree-like Html type describing the widget. Using `name` we can make it that
we only see the widget name instead.

    type ChatBoxWidget
        = ChatBoxWidget ( H2 String, List Message )

    view : Model -> Html ChatBoxWidget msg
    view model =
        name ChatBoxWidget
            ( h2 (text "Chatbox")
            , list (List.map viewMessage model.messages)
            )

-}
name : (a -> b) -> Html a msg -> Html b msg
name _ (Html subHtml) =
    Html subHtml


mapSubHtml : (msgA -> msgB) -> SubHtml msgA -> SubHtml msgB
mapSubHtml fn subHtml =
    case subHtml of
        Node tag attrs child ->
            Node tag (List.map (mapAttr fn) attrs) (mapSubHtml fn child)

        Text text ->
            Text text

        List children ->
            List (List.map (mapSubHtml fn) children)

        Raw html ->
            Raw (Html.map fn html)



-- # Html generation
-- One example of a view interpreter, this one producing plain Html.


toRaw : Html tipe msg -> Html.Html msg
toRaw (Html subHtml) =
    mkSubHtml [] subHtml


fromRaw : Html.Html msg -> Html tipe msg
fromRaw html =
    Html <| Raw html


mkSubHtml : List (Html.Attribute msg) -> SubHtml msg -> Html.Html msg
mkSubHtml attrs subHtml =
    case subHtml of
        Node tag attrs child ->
            Html.node tag (List.map mkAttr attrs) (List.map (mkSubHtml []) (toChildren child))

        Text text ->
            Html.text text

        List children ->
            Html.div attrs (List.map (mkSubHtml []) children)

        Raw html ->
            html


toChildren : SubHtml msg -> List (SubHtml msg)
toChildren subHtml =
    case subHtml of
        Node _ _ _ ->
            [ subHtml ]

        Text _ ->
            [ subHtml ]

        List children ->
            children

        Raw _ ->
            []
