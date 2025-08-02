# Usamos una imagen oficial de Python como base.
FROM python:3.11-slim

# Establecemos el directorio de trabajo dentro del contenedor.
WORKDIR /app

# Añadimos el directorio actual a la ruta de búsqueda de Python.
ENV PYTHONPATH "${PYTHONPATH}:/app"

# Copiamos primero el archivo de requerimientos.
COPY requirements.txt .

# Instalamos todas las dependencias que nuestro proyecto necesita.
RUN pip install --no-cache-dir -r requirements.txt

# Ahora copiamos todo el código de nuestra aplicación.
COPY ./app .

# --- LÍNEA CORREGIDA ---
# Le decimos a Uvicorn que ejecute el objeto "app" desde el archivo "main.py".
# Como ya estamos en el directorio /app, no necesitamos prefijarlo.
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
