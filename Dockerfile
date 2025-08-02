# Usamos una imagen oficial de Python como base.
FROM python:3.11-slim

# Establecemos el directorio de trabajo dentro del contenedor.
WORKDIR /app

# --- LÍNEA NUEVA AÑADIDA ---
# Le decimos a Python que añada el directorio actual a su ruta de búsqueda.
# Esto resuelve el error "ModuleNotFoundError".
ENV PYTHONPATH "${PYTHONPATH}:/app"

# Copiamos primero el archivo de requerimientos.
COPY requirements.txt .

# Instalamos todas las dependencias que nuestro proyecto necesita.
RUN pip install --no-cache-dir -r requirements.txt

# Ahora copiamos todo el código de nuestra aplicación.
COPY ./app /app

# Este es el comando que se ejecutará cuando el contenedor se inicie.
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
