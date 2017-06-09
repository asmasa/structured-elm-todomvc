module View.Todo.TodoItem exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode as Json
import Model.Todo as Todo
import Todo exposing (Msg(..))
import TodoList exposing (..)
import View.Todo.Events exposing (onEnter)


todoItem : Todo.Model -> Html TodoList.Msg
todoItem todo =
    li [ classList [ ( "completed", todo.completed ), ( "editing", todo.editing ) ] ]
        [ div [ class "view" ]
            [ input
                [ class "toggle"
                , type_ "checkbox"
                , checked todo.completed
                , onClick (MsgForTodo todo.id <| Check (not todo.completed))
                ]
                []
            , label [ onDoubleClick (MsgForTodo todo.id <| Editing True) ]
                [ text todo.description ]
            , button
                [ class "destroy"
                , onClick (Delete todo.id)
                ]
                []
            ]
        , input
            [ class "edit"
            , value todo.description
            , name "title"
            , id ("todo-" ++ toString todo.id)
            , on "input" (Json.map (MsgForTodo todo.id << Update) targetValue)
            , onBlur (MsgForTodo todo.id <| Editing False)
            , onEnter TodoList.NoOp (MsgForTodo todo.id <| Editing False)
            ]
            []
        ]
