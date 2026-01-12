from fastapi.testclient import TestClient
from main import app, db
import pytest

client = TestClient(app)

@pytest.fixture(autouse=True)
def setup_and_teardown():
    db.clear()
    yield
    db.clear()

def test_create_todo():
    response = client.post("/todos", json={"title": "Test Todo", "reminderInterval": 60})
    assert response.status_code == 201
    data = response.json()
    assert data["title"] == "Test Todo"
    assert data["reminderInterval"] == 60
    assert "id" in data

def test_get_todos():
    response = client.get("/todos")
    assert response.status_code == 200
    assert isinstance(response.json(), list)

def test_get_todo():
    # First, create a todo to get
    response = client.post("/todos", json={"title": "Test Todo 2", "reminderInterval": 120})
    assert response.status_code == 201
    todo_id = response.json()["id"]

    # Now, get it
    response = client.get(f"/todos/{todo_id}")
    assert response.status_code == 200
    data = response.json()
    assert data["id"] == todo_id
    assert data["title"] == "Test Todo 2"

def test_update_todo():
    # First, create a todo to update
    response = client.post("/todos", json={"title": "Test Todo 3", "reminderInterval": 180})
    assert response.status_code == 201
    todo_id = response.json()["id"]

    # Now, update it
    response = client.put(f"/todos/{todo_id}", json={"title": "Updated Todo 3"})
    assert response.status_code == 200
    data = response.json()
    assert data["title"] == "Updated Todo 3"
    assert data["reminderInterval"] == 180

def test_delete_todo():
    # First, create a todo to delete
    response = client.post("/todos", json={"title": "Test Todo 4", "reminderInterval": 240})
    assert response.status_code == 201
    todo_id = response.json()["id"]

    # Now, delete it
    response = client.delete(f"/todos/{todo_id}")
    assert response.status_code == 204

    # Verify it's gone
    response = client.get(f"/todos/{todo_id}")
    assert response.status_code == 404
