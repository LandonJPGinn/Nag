from fastapi import FastAPI, HTTPException
from typing import List
from uuid import UUID
from models import TodoItem, TodoUpdate, TodoCreate

app = FastAPI()

# In-memory database
db: List[TodoItem] = []


@app.get("/")
async def root():
    return {"message": "Hello World"}


@app.get("/todos", response_model=List[TodoItem])
async def get_todos():
    return db


@app.post("/todos", response_model=TodoItem, status_code=201)
async def create_todo(todo_create: TodoCreate):
    todo = TodoItem(**todo_create.model_dump())
    db.append(todo)
    return todo


@app.get("/todos/{todo_id}", response_model=TodoItem)
async def get_todo(todo_id: UUID):
    for todo in db:
        if todo.id == todo_id:
            return todo
    raise HTTPException(status_code=404, detail="Todo not found")


@app.put("/todos/{todo_id}", response_model=TodoItem)
async def update_todo(todo_id: UUID, todo_update: TodoUpdate):
    for todo in db:
        if todo.id == todo_id:
            if todo_update.title is not None:
                todo.title = todo_update.title
            if todo_update.isCompleted is not None:
                todo.isCompleted = todo_update.isCompleted
            if todo_update.reminderInterval is not None:
                todo.reminderInterval = todo_update.reminderInterval
            return todo
    raise HTTPException(status_code=404, detail="Todo not found")


@app.delete("/todos/{todo_id}", status_code=204)
async def delete_todo(todo_id: UUID):
    for i, todo in enumerate(db):
        if todo.id == todo_id:
            del db[i]
            return
    raise HTTPException(status_code=404, detail="Todo not found")
