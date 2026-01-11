FROM python:3.11-slim

WORKDIR /app

# System dependencies for lxml, pymorphy3
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    libxml2-dev \
    libxslt1-dev \
    && rm -rf /var/lib/apt/lists/*

# Install uv package manager
RUN pip install --no-cache-dir uv

# Copy dependency files first for layer caching
COPY pyproject.toml uv.lock ./

# Install dependencies
RUN uv sync --frozen --no-dev

# Copy source code
COPY src/ ./src/

# Copy ML modules (without heavy model files yet)
COPY code/ ./code/

# Copy ML models (tracked via Git LFS)
COPY models/ ./models/

# Environment variables for model paths
ENV CLICKBAIT_MODEL_PATH=/app/models/clickbait
ENV WATER_MODEL_PATH=/app/models/ruber_quality_model.pkl
ENV WATER_MODULE_PATH=/app/code/water/water_analyzer.py
ENV CLICKBAIT_MODULE_PATH=/app/code/klikbait/predict.py

EXPOSE 8000

CMD ["uv", "run", "python", "-m", "src.api.main"]
