from typing import Optional

from pydantic import BaseModel, Field


class Task(BaseModel):
    id: int
    title: Optional[bool] = Field(None, example="クリーニングを取りに行く")
    done: bool = Field(False, description="完了フラグ")