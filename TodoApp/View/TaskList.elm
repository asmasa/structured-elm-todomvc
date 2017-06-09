module TodoApp.View.TaskList exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import TodoApp.Task as Task
import TodoApp.TaskList exposing (..)
import TodoApp.View.Task.TodoItem exposing (todoItem)


taskList : String -> List Task.Model -> Html Msg
taskList visibility tasks =
    let
        isVisible todo =
            case visibility of
                "Completed" ->
                    todo.completed

                "Active" ->
                    not todo.completed

                _ ->
                    True

        allCompleted =
            List.all .completed tasks

        cssVisibility =
            if List.isEmpty tasks then
                "hidden"
            else
                "visible"
    in
    section
        [ id "main"
        , style [ ( "visibility", cssVisibility ) ]
        ]
        [ input
            [ id "toggle-all"
            , type_ "checkbox"
            , name "toggle"
            , checked allCompleted
            , onClick (CheckAll (not allCompleted))
            ]
            []
        , label [ for "toggle-all" ]
            [ text "Mark all as complete" ]
        , ul [ id "todo-list" ]
            (List.map todoItem (List.filter isVisible tasks))
        ]
