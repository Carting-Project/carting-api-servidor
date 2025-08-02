from fastapi import FastAPI
from .routers import auth

app = FastAPI(
    title="Carting API",
    description="El backend para el ecosistema Carting.",
    version="1.0.0"
)

# Incluimos las rutas de autenticación que creamos
app.include_router(auth.router)

@app.get("/")
def read_root():
    return {"status": "Carting API está funcionando!"}
