# Use an official Python runtime
FROM python:3.10-slim

# Install system dependencies (uncomment Java if using tabula PDF extraction)
# If you keep tabula, you likely need Java:
# RUN apt-get update && apt-get install -y --no-install-recommends \
#     default-jre-headless \
#     && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Install Python dependencies first for better layer caching
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the app
COPY . .

# Render sets PORT; expose is informational only
EXPOSE 8080
ENV PORT=10000

# Bind uvicorn to 0.0.0.0 and the Render-provided $PORT
CMD uvicorn app:app --host 0.0.0.0 --port ${PORT}
