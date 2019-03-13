module JsonModule exposing (..)
import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http
import Json.Decode exposing (Decoder,map2,field,string)



--main

main =
    Browser.element
    {
    init = init,
    update = update,
    subscriptions = subscriptions,
    view = view
    }



-- model 准备解析 server response 的json 里的 title 和 image_url
type alias Gif =
    { title: String ,url:String}
-- model 定义状态模型   失败，  加载中， 成功
type Model
    = Failure
    | Loading
    | Success Gif

-- init
init: () -> (Model,Cmd Msg)
init _= (Loading, getRandomCatGif)


--update
type Msg
    = MorePlease
    | GotGif(Result Http.Error Gif)


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    MorePlease ->
      (Loading, getRandomCatGif)

    GotGif result ->
      case result of
        Ok gif ->
          (Success gif, Cmd.none)

        Err _ ->
          (Failure, Cmd.none)




--subscriptions

subscriptions: Model -> Sub Msg

subscriptions model =
    Sub.none


--view

view: Model -> Html Msg

view model =
    div[]
    [h2 [] [text "Random Cats"],
     viewGif model
    ]

viewGif: Model -> Html Msg

viewGif model=
    case model of
        Failure ->
              div []
                [ text "I could not load a random cat for some reason. "
                , button [ onClick MorePlease ] [ text "Try Again!" ]
                ]

        Loading ->
              text "Loading..."

        Success gif ->
              div []
                [ button [ onClick MorePlease, style "display" "block" ] [ text "More Please!" ]
                  , p [] [text gif.title]
                , img [ src gif.url ] []
                ]


-- HTTP


getRandomCatGif : Cmd Msg
getRandomCatGif =
  Http.get
    { url = "https://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag=cat"
    , expect = Http.expectJson GotGif gifDecoder
    }

-- 两个解码器结合 
gifDecoder : Decoder Gif
gifDecoder =
  map2 Gif
    (field "data" (field "title" string))
    (field "data" (field "image_url" string))



















