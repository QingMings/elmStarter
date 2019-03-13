module Variant exposing (..)

type User
    = Regular String Int
    | Visitor String
--thomas: User
--thomas = Regular "Thomas"
--kate95: User
--kate95 = Visitor "kate95"

--type User2
--    = Regular String Int
--    | Visitor String
--
--
--thomas2: User2
--thomas2 = Regular "Thomas" 32
--kate952: User2
--kate952 = Visitor "kate95"

type Msg
    = PressedEnter
    | ChangedDraft String
    | ReceivedMessage {user: User, message: String }
    | ClickedExit


type Profile
    = Failure
    | Loading
    | Successs {name: String, description: String}



toName: User -> String
toName user =
    case user of
        Regular name _ ->
            name

        Visitor name ->
            name





























