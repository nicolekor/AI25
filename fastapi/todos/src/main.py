
from fastapi import FastAPI
from api.todo import router as todo_router
from api.user import router as user_router
app = FastAPI(
    title="ToDo API",
    version="1.0.0"
)

@app.get("/", tags=["Health"])
def health_check_handler():
    return {"ping": "pong"}

# 라우터 등록
app.include_router(todo_router)
# 📁 src/main.py
from fastapi import FastAPI
from api.todo import router as todo_router

app = FastAPI(
    title="ToDo API",
    version="1.0.0"
)

@app.get("/", tags=["Health"])
def health_check_handler():
    return {"ping": "pong"}

# 라우터 등록
app.include_router(todo_router)
app.include_router(user_router)

