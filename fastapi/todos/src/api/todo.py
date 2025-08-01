# 📁 src/api/todo.py
from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from typing import List, Optional

from database.connection import get_db
from database.orm import ToDo
from database.repository import (
    get_todo_by_todo_id,
    get_todos,
    create_todo,
    update_todo,
    delete_todo,
)
from schema.request import CreateToDoRequest
from schema.response import ToDoSchema, ToDoListSchema

router = APIRouter(
    prefix="/todos",
    tags=["ToDos"]
)

def raise_404_if_none(data, message="항목을 찾을 수 없습니다."):
    if data is None:
        raise HTTPException(status_code=404, detail=message)
    return data

@router.get("/", response_model=ToDoListSchema)
def get_todos_handler(order: Optional[str] = None, session: Session = Depends(get_db)):
    todos: List[ToDo] = get_todos(session=session)
    if order == "DESC":
        todos.reverse()
    return ToDoListSchema(todos=[ToDoSchema.model_validate(todo) for todo in todos])

@router.get("/{todo_id}", response_model=ToDoSchema)
def get_todo_handler(todo_id: int, session: Session = Depends(get_db)):
    todo = get_todo_by_todo_id(session, todo_id) 
    return ToDoSchema.model_validate(raise_404_if_none(todo, "할 일을 찾을 수 없습니다."))

@router.post("/", response_model=ToDoSchema, status_code=status.HTTP_201_CREATED)
def create_todo_handler(todo_data: CreateToDoRequest, session: Session = Depends(get_db)):
    new_todo = create_todo(todo_data, session)
    return ToDoSchema.model_validate(new_todo)

@router.patch("/{todo_id}", response_model=ToDoSchema)
def update_todo_handler(todo_id: int, todo_data: CreateToDoRequest, session: Session = Depends(get_db)):
    updated = update_todo(todo_id, todo_data, session)
    return ToDoSchema.model_validate(raise_404_if_none(updated, "수정할 할 일을 찾을 수 없습니다."))

@router.delete("/{todo_id}", status_code=status.HTTP_204_NO_CONTENT)
def delete_todo_handler(todo_id: int, session: Session = Depends(get_db)):
    deleted = delete_todo(todo_id, session)
    raise_404_if_none(deleted, "삭제할 할 일을 찾을 수 없습니다.")
    return None
