from fastapi import APIRouter, HTTPException, Depends
from pydantic import BaseModel, EmailStr
# Importamos desde la nueva ubicación correcta de db.py
from ..db import get_db, Session

router = APIRouter(
    prefix="/auth",
    tags=["Authentication"]
)

class UserCreate(BaseModel):
    email: EmailStr
    password: str
    nombre_completo: str

def get_password_hash(password: str):
    return f"hashed_{password}"

@router.post("/register", status_code=201)
async def register_user(user: UserCreate, db: Session = Depends(get_db)):
    query = """
        INSERT INTO usuarios (email, password_hash, nombre_completo)
        VALUES (:email, :password_hash, :nombre_completo)
        RETURNING id;
    """
    values = {
        "email": user.email,
        "password_hash": get_password_hash(user.password),
        "nombre_completo": user.nombre_completo
    }
    try:
        new_user_id = db.execute(query, values).fetchone()[0]
        db.commit()
    except Exception as e:
        db.rollback()
        raise HTTPException(status_code=400, detail=f"No se pudo registrar el usuario. Error: {e}")

    return {
        "message": "Usuario creado con éxito",
        "user_id": new_user_id,
        "email": user.email
    }
