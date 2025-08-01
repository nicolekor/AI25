from fastapi import Depends
from database.connection import get_db
from sqlalchemy.orm import Session
from sqlalchemy import select
from database.orm import ToDo, User
from schema.request import CreateToDoRequest
from pydantic import BaseModel



def get_todos(session: Session) -> list[ToDo]:
    stmt = select(ToDo)
    return session.execute(stmt).scalars().all()


def get_todo_by_todo_id(session: Session, todo_id: int) -> ToDo | None:
    stmt = select(ToDo).where(ToDo.id == todo_id)
    return session.execute(stmt).scalar_one_or_none()


def create_todo(session: Session, request: CreateToDoRequest) -> ToDo:
    new_todo = ToDo(contents=request.contents, is_done=request.is_done)
    session.add(new_todo)
    session.commit()
    session.refresh(new_todo)
    return new_todo


def update_todo(session: Session, todo_id: int, is_done: bool) -> ToDo | None:
    todo = get_todo_by_todo_id(session, todo_id)
    if not todo:
        return None
    todo.is_done = is_done
    session.commit()
    session.refresh(todo)
    return todo


def delete_todo(session: Session, todo_id: int) -> bool:
    todo = get_todo_by_todo_id(session, todo_id)
    if not todo:
        return False
    session.delete(todo)
    session.commit()
    return True

class UserRepository:
    def __init__(self, session: Session = Depends(get_db)):
        self.session = session
        
    def save_user(self, user: User) -> User:
        self.session.add(user)
        self.session.commit()
        self.session.refresh(user)   
        return user
    
class UserSchema(BaseModel):
    id: int
    username: str

    model_config = {
        "from_attributes": True
    }