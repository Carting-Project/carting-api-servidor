# Usamos una imagen oficial de Python como base.
FROM python:3.11-slim

# Establecemos el directorio de trabajo dentro del contenedor.
WORKDIR /app

# Le decimos a Python que añada el directorio actual a su ruta de búsqueda.
# ESTA LÍNEA ARREGLÓ EL PRIMER ERROR.
ENV PYTHONPATH "${PYTHONPATH}:/app"

# Copiamos primero el archivo de requerimientos.
COPY requirements.txt .

# Instalamos todas las dependencias que nuestro proyecto necesita.
RUN pip install --no-cache-dir -r requirements.txt

# Ahora copiamos todo el código de nuestra aplicación.
COPY ./app .

# --- LÍNEA CORREGIDA (DE NUEVO) ---
# Le decimos a Uvicorn que ejecute el objeto "app" desde el MÓDULO "app.main".
# ESTA LÍNEA, COMBINADA CON LA ANTERIOR, ARREGLA EL SEGUNDO ERROR.
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
