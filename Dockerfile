# Small, secure base
FROM python:3.12-slim

# Python quality-of-life envs
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Create working dir
WORKDIR /app

# Non-root user for better security
RUN adduser --disabled-password --gecos "" appuser

# Install deps first (leverages layer caching)
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy app code
COPY . .

# Drop privileges
USER appuser

# Container will listen on 8000
EXPOSE 8000

# Simple health check (hits our /healthz)
HEALTHCHECK --interval=30s --timeout=3s --retries=3 \
  CMD python -c "import urllib.request; urllib.request.urlopen('http://127.0.0.1:8000/healthz')" || exit 1

# Use Gunicorn in the container (prod-grade server)
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "-w", "2", "app:app"]