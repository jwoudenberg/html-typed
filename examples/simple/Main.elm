module Main exposing (..)

import Html
import Html.Typed exposing (..)
import Html.Typed.Events exposing (..)


type alias Model =
    { posts : List Post
    , currentPost : Maybe Int
    }


type Msg
    = ToPost Int
    | ToHome


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = init
        , view = view >> Html.Typed.toRaw
        , update = update
        }


update : Msg -> Model -> Model
update msg model =
    case msg of
        ToPost id ->
            { model | currentPost = Just id }

        ToHome ->
            { model | currentPost = Nothing }


init : Model
init =
    { posts =
        [ { id = 1, title = "Bears", content = "A treatise on bears." }
        , { id = 2, title = "Sharks", content = "Not nearly as awesome as bears." }
        ]
    , currentPost = Nothing
    }


type Page
    = Page Header Body


type alias Header =
    H1 { onClick : Msg } String


type Body
    = ListPosts (List SinglePost)
    | SinglePost SinglePost


type alias SinglePost =
    Section {} PostBody


type PostBody
    = PostBody PostTitle PostContent


type alias PostTitle =
    H2 { onClick : Msg } String


type alias PostContent =
    P {} String


type alias Post =
    { id : Int
    , title : String
    , content : String
    }


view : Model -> Html Page Msg
view model =
    let
        currentPost : Maybe Post
        currentPost =
            model.posts
                |> List.filter (\p -> Just p.id == model.currentPost)
                |> List.head
    in
    into2 Page
        viewHeader
        (case currentPost of
            Nothing ->
                into ListPosts <| viewHome model.posts

            Just post ->
                into SinglePost <| viewPost post
        )


viewHeader : Html Header Msg
viewHeader =
    h1 [ onClick ToHome ] (text "My Blog!")


viewHome : List Post -> Html (List SinglePost) Msg
viewHome posts =
    list <| List.map viewPost posts


viewPost : Post -> Html SinglePost Msg
viewPost post =
    section [] <|
        into2 PostBody
            (viewTitle post)
            (p [] <| text post.content)


viewTitle : Post -> Html PostTitle Msg
viewTitle post =
    h2
        [ onClick (ToPost post.id) ]
        (text post.title)
