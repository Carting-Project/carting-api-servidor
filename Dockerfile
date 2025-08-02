# Usamos una imagen oficial de Python como base.
# La versión "slim" es más ligera, lo que hace nuestro contenedor más eficiente.
FROM python:3.11-slim

# Establecemos el directorio de trabajo dentro del contenedor.
# Todas las acciones a partir de ahora se harán dentro de la carpeta /app.
WORKDIR /app

# Copiamos primero el archivo de requerimientos.
COPY requirements.txt .

# Instalamos todas las dependencias que nuestro proyecto necesita.
# --no-cache-dir es una optimización para que la imagen no guarde archivos innecesarios.
RUN pip install --no-cache-dir -r requirements.txt

# Ahora copiamos todo el código de nuestra aplicación (la carpeta ./app de nuestro PC)
# al directorio de trabajo (/app) dentro del contenedor.
COPY ./app /app

# Este es el comando que se ejecutará cuando el contenedor se inicie.
# Le dice a Uvicorn que inicie nuestra aplicación FastAPI.
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
