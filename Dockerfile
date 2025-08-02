FROM python:3.11-slim
WORKDIR /app
ENV PYTHONPATH "${PYTHONPATH}:/app"
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY ./app .

# Comando de depuración: Mantiene el contenedor corriendo sin hacer nada.
CMD ["tail", "-f", "/dev/null"]
