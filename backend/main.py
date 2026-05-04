from fastapi import FastAPI
from pydantic import BaseModel
import psycopg2
import os

app = FastAPI()


class UserIn(BaseModel):
    name: str


def get_connection():
    return psycopg2.connect(
        host=os.getenv("DB_HOST"),
        database=os.getenv("DB_NAME"),
        user=os.getenv("DB_USER"),
        password=os.getenv("DB_PASSWORD"),
    )


@app.get("/")
def root():
    return {"message": "Hello from FastAPI Backend"}


@app.get("/db-check")
def db_check():
    try:
        conn = get_connection()
        conn.close()
        return {"database": "connected"}
    except Exception as e:
        return {"database": "connection failed", "error": str(e)}


@app.post("/users")
def create_user(user: UserIn):
    conn = get_connection()
    cur = conn.cursor()

    cur.execute("""
        CREATE TABLE IF NOT EXISTS users (
            id SERIAL PRIMARY KEY,
            name TEXT NOT NULL
        )
    """)

    cur.execute(
        "INSERT INTO users (name) VALUES (%s) RETURNING id, name",
        (user.name,)
    )

    new_user = cur.fetchone()
    conn.commit()

    cur.close()
    conn.close()

    return {
        "id": new_user[0],
        "name": new_user[1],
        "status": "user created"
    }


@app.get("/users")
def get_users():
    conn = get_connection()
    cur = conn.cursor()

    cur.execute("""
        CREATE TABLE IF NOT EXISTS users (
            id SERIAL PRIMARY KEY,
            name TEXT NOT NULL
        )
    """)

    cur.execute("SELECT id, name FROM users ORDER BY id")
    rows = cur.fetchall()

    cur.close()
    conn.close()

    return [{"id": row[0], "name": row[1]} for row in rows]