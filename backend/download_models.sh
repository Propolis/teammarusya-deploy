#!/bin/bash
# Download ML models at container startup
set -e

echo "Downloading ML models..."

# Create models directory
mkdir -p /app/models/clickbait

# Download water quality model (315MB)
if [ ! -f "/app/models/ruber_quality_model.pkl" ]; then
    echo "Downloading ruber_quality_model.pkl..."
    curl -L -o /app/models/ruber_quality_model.pkl \
        "https://github.com/Propolis/teammarusya-deploy/releases/download/models-v1/ruber_quality_model.pkl" || \
        echo "Warning: Could not download ruber_quality_model.pkl"
fi

# Download logreg water model (small)
if [ ! -f "/app/models/logreg_water_model.pkl" ]; then
    echo "Downloading logreg_water_model.pkl..."
    curl -L -o /app/models/logreg_water_model.pkl \
        "https://github.com/Propolis/teammarusya-deploy/releases/download/models-v1/logreg_water_model.pkl" || \
        echo "Warning: Could not download logreg_water_model.pkl"
fi

# Download clickbait model from HuggingFace or GitHub Release
if [ ! -d "/app/models/clickbait/checkpoint-113" ]; then
    echo "Downloading clickbait model..."
    mkdir -p /app/models/clickbait/checkpoint-113
    
    # Download model files
    for file in config.json model.safetensors special_tokens_map.json tokenizer.json tokenizer_config.json vocab.txt; do
        curl -L -o "/app/models/clickbait/checkpoint-113/$file" \
            "https://github.com/Propolis/teammarusya-deploy/releases/download/models-v1/$file" || \
            echo "Warning: Could not download $file"
    done
fi

echo "Models downloaded successfully!"
