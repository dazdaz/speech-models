#!/bin/bash
set -e

echo "Setting up Sopro TTS environment..."

if [ ! -d ".venv" ]; then
    echo "Creating virtual environment..."
    python3 -m venv .venv
fi

source .venv/bin/activate

echo "Installing dependencies..."
pip install --upgrade pip
pip install sopro torch

echo "Creating a sample reference audio..."
python3 -c "
import numpy as np
import soundfile as sf
sr = 24000
duration = 3.0
t = np.linspace(0, duration, int(sr * duration), dtype=np.float32)
audio = 0.3 * np.sin(2 * np.pi * 440 * t) * np.exp(-t / 2)
sf.write('ref_sample.wav', audio, sr)
print('Reference audio created: ref_sample.wav')
"

echo "Pre-downloading model weights..."
python3 -c "from sopro import SoproTTS; SoproTTS.from_pretrained('samuel-vitorino/sopro', device='cpu'); print('Model downloaded successfully!')"

echo ""
echo "Setup complete! Run the demo with:"
echo "  source .venv/bin/activate"
echo "  python demo.py"
