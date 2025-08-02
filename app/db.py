# Este archivo simulará nuestra conexión a la base de datos por ahora.
# Más adelante lo conectaremos al contenedor de PostgreSQL.

class DBSession:
    def execute(self, query, values):
        print("--- Ejecutando Query ---")
        print(query)
        print("--- Con Valores ---")
        print(values)
        # Simulamos que devuelve un ID de usuario
        class MockResult:
            def fetchone(self):
                return (1,) # Devuelve una tupla como lo haría una BD real
        return MockResult()

    def commit(self):
        print("--- Haciendo Commit (Guardando cambios) ---")

    def rollback(self):
        print("--- Haciendo Rollback (Revirtiendo cambios) ---")

def get_db():
    # Esta función entrega una sesión de base de datos a los endpoints.
    db = DBSession()
    try:
        yield db
    finally:
        # Aquí iría la lógica para cerrar la conexión.
        pass

# Para que Alembic (migraciones) funcione, necesitamos una clase Session
class Session:
    pass
