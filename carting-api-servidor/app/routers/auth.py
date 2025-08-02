# /app/routers/auth.py
from fastapi import APIRouter, HTTPException
from pydantic import BaseModel, EmailStr

# APIRouter nos permite agrupar rutas relacionadas en un solo archivo.
router = APIRouter(
    prefix="/auth",
    tags=["Authentication"]
)

# Pydantic nos ayuda a definir cómo deben lucir los datos que recibimos.
# Si la app envía datos que no cumplen este formato, la API los rechaza.
class UserCreate(BaseModel):
    email: EmailStr
    password: str
    nombre_completo: str

# Simulación de una función para "hashear" la contraseña.
def get_password_hash(password: str):
    # En un futuro, aquí usaremos una librería de criptografía como passlib.
    # Por ahora, solo añadimos "hashed_" para simular el proceso.
    return f"hashed_{password}"

@router.post("/register", status_code=201)
async def register_user(user: UserCreate):
    """
    Endpoint para registrar un nuevo usuario en la base de datos.
    """
    # Aquí iría la lógica para guardar el usuario en la base de datos.
    # Por ahora, simulamos el proceso.
    hashed_password = get_password_hash(user.password)

    print(f"Usuario a crear: {user.email}, Nombre: {user.nombre_completo}, Pass-Hashed: {hashed_password}")

    # En una aplicación real, verificaríamos si el email ya existe.
    # Si ya existiera, devolveríamos un error:
    # raise HTTPException(status_code=400, detail="El correo electrónico ya está registrado")

    return {"message": f"Usuario '{user.nombre_completo}' creado con éxito."}
