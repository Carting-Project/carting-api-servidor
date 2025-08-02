# Este archivo simulará nuestra conexión a la base de datos por ahora.
class DBSession:
    def execute(self, query, values):
        print("--- Ejecutando Query ---")
        print(query)
        print("--- Con Valores ---")
        print(values)
        class MockResult:
            def fetchone(self):
                return (1,)
        return MockResult()
    def commit(self):
        print("--- Haciendo Commit (Guardando cambios) ---")
    def rollback(self):
        print("--- Haciendo Rollback (Revirtiendo cambios) ---")

def get_db():
    db = DBSession()
    try:
        yield db
    finally:
        pass

class Session:
    pass
