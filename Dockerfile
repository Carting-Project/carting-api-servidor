# Usamos una imagen oficial de Python como base.
FROM python:3.11-slim

# 1. Creamos un directorio de trabajo neutro llamado /code
WORKDIR /code

# 2. Copiamos solo el archivo de requerimientos al nuevo directorio.
COPY requirements.txt /code/requirements.txt

# 3. Instalamos las dependencias.
RUN pip install --no-cache-dir -r /code/requirements.txt

# 4. Copiamos toda nuestra carpeta de código "app" a una subcarpeta
# dentro de nuestro directorio de trabajo. La estructura final será /code/app/main.py
COPY ./app /code/app

# 5. El comando ahora funciona sin ambigüedad. Desde /code, Uvicorn
# puede encontrar y ejecutar el paquete "app" y el módulo "main".
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
