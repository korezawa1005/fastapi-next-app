from fastapi import FastAPI

from api.routers import task, done

app = FastAPI(
    title="Todo API",
    version="0.1.0",
    description="Simple todo app built with FastAPI.",
)
app.include_router(task.router)
app.include_router(done.router)
