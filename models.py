from pydantic import BaseModel, Field
from datetime import datetime, timezone
from uuid import UUID, uuid4
from typing import Optional

class TodoCreate(BaseModel):
    title: str
    reminderInterval: int

class TodoItem(TodoCreate):
    id: UUID = Field(default_factory=uuid4)
    isCompleted: bool = False
    createdAt: datetime = Field(default_factory=lambda: datetime.now(timezone.utc))

class TodoUpdate(BaseModel):
    title: Optional[str] = None
    isCompleted: Optional[bool] = None
    reminderInterval: Optional[int] = None
