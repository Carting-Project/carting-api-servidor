from fastapi import APIRouter, HTTPException, Depends
from pydantic import BaseModel, EmailStr
# Simulación de nuestra conexión a la base de datos
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
    """
    Endpoint para registrar un nuevo usuario. Ahora interactúa con la BD.
    """
    # 1. Hashear la contraseña
    hashed_password = get_password_hash(user.password)

    # 2. Crear la sentencia SQL para insertar el nuevo usuario
    query = """
        INSERT INTO usuarios (email, password_hash, nombre_completo)
        VALUES (:email, :password_hash, :nombre_completo)
        RETURNING id;
    """
    values = {
        "email": user.email,
        "password_hash": hashed_password,
        "nombre_completo": user.nombre_completo
    }

    try:
        # 3. Ejecutar la sentencia en la base de datos
        new_user_id = db.execute(query, values).fetchone()[0]
        db.commit() # Confirmar la transacción
    except Exception as e:
        # Si algo sale mal (ej. el email ya existe), revertimos y lanzamos un error
        db.rollback()
        raise HTTPException(status_code=400, detail=f"No se pudo registrar el usuario. Error: {e}")

    return {
        "message": "Usuario creado con éxito",
        "user_id": new_user_id,
        "email": user.email
    }
