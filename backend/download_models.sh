#!/bin/bash
# Download ML models at container startup
set -e

echo "Setting up ML models..."

# Create models directory
mkdir -p /app/models/clickbait/checkpoint-113

# For production: download from HuggingFace or GitHub Release
# For now: use models from code/ directory if available (during transition)

# Copy water quality models if they exist in code/
if [ -f "/app/code/water/ruber_quality_model.pkl" ]; then
    echo "Using ruber_quality_model.pkl from code directory"
    cp /app/code/water/ruber_quality_model.pkl /app/models/
else
    echo "Warning: ruber_quality_model.pkl not found"
fi

if [ -f "/app/code/water/logreg_water_model.pkl" ]; then
    echo "Using logreg_water_model.pkl from code directory"
    cp /app/code/water/logreg_water_model.pkl /app/models/
else
    echo "Warning: logreg_water_model.pkl not found"
fi

# Copy clickbait model if it exists
if [ -d "/app/code/klikbait/my_awesome_model/checkpoint-113" ]; then
    echo "Using clickbait model from code directory"
    cp -r /app/code/klikbait/my_awesome_model/checkpoint-113/* /app/models/clickbait/checkpoint-113/
else
    echo "Warning: clickbait model not found"
fi

echo "Model setup complete!"
