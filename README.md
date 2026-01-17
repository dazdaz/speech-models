# Sopro TTS Demo

A sample app for [Sopro](https://github.com/samuel-vitorino/sopro) - a lightweight 169M parameter text-to-speech model with voice cloning.

## Setup

```bash
./setup.sh
```

This will:
- Create a Python virtual environment
- Install dependencies (sopro, torch)
- Download the model weights

## Usage

```bash
./demo.py -t "Your text here" -r reference.wav -o output.mp3 --device mps
```

### Options

| Option | Description |
|--------|-------------|
| `-t, --text` | Text to synthesize |
| `-r, --ref` | Reference audio for voice cloning (3-10 seconds of speech) |
| `-o, --output` | Output file path (.wav or .mp3) |
| `-d, --device` | Compute device: `cpu`, `cuda` (NVIDIA), or `mps` (Apple Silicon) |
| `-s, --stream` | Enable streaming mode (generates audio in chunks) |

### Examples

```bash
# Basic synthesis
./demo.py -t "Hello world" -r samantha.wav -o output.mp3 --device mps

# Using streaming mode
./demo.py -t "Hello world" -r samantha.wav -o output.mp3 --device mps --stream

# Output as WAV
./demo.py -t "Hello world" -r samantha.wav -o output.wav --device mps
```

### Playing Output

```bash
# Play audio (macOS)
afplay output.mp3

# Adjust volume (0.0 to 2.0+)
afplay -v 0.5 output.mp3    # 50% volume (quieter)
afplay -v 1.0 output.mp3    # Normal volume
afplay -v 2.0 output.mp3    # 2x volume (louder)

# Alternative players
mpg123 output.mp3           # Requires: brew install mpg123
ffplay -nodisp output.mp3   # Requires: ffmpeg installed
```

## Creating Reference Audio

The reference audio is a 3-10 second speech sample that the model clones. The output will mimic the voice characteristics (tone, pitch, accent) from this file.

### Quick Setup (Recommended)

Run the interactive helper script:

```bash
./create_reference.sh
```

This lets you either record your own voice or use a macOS system voice.

### What to Say

For best voice cloning results, use this text (covers many phonemes):

> "The quick brown fox jumps over the lazy dog. Pack my box with five dozen liquor jugs."

This takes about 5-8 seconds to read naturally and contains all letters of the alphabet plus common sound combinations.

### Option 1: Use macOS Text-to-Speech

```bash
# List available voices
say -v "?"

# Create reference with Samantha (female US)
say -v "Samantha" -o samantha.aiff "The quick brown fox jumps over the lazy dog. Pack my box with five dozen liquor jugs."
ffmpeg -y -i samantha.aiff -ar 24000 samantha.wav

# Create reference with Daniel (male UK)
say -v "Daniel" -o daniel.aiff "The quick brown fox jumps over the lazy dog. Pack my box with five dozen liquor jugs."
ffmpeg -y -i daniel.aiff -ar 24000 daniel.wav
```

### Option 2: Record Your Own Voice

**Using the command line (requires sox or ffmpeg):**

```bash
# Record 6 seconds of audio
ffmpeg -f avfoundation -i ":0" -t 6 -ar 24000 -ac 1 my_voice.wav
```

**Using macOS apps:**

1. **Voice Memos** (easiest)
   - Open Voice Memos app
   - Record yourself reading the sample text
   - Share > Save to Files > Save as .m4a
   - Convert: `ffmpeg -i recording.m4a -ar 24000 my_voice.wav`

2. **QuickTime Player**
   - File > New Audio Recording
   - Record, then File > Save
   - Convert: `ffmpeg -i recording.m4a -ar 24000 my_voice.wav`

3. **GarageBand** - For higher quality recordings with noise reduction

### Tips for Good Reference Audio

| Do | Don't |
|----|-------|
| Use a quiet room | Record near fans/AC |
| Speak 6-12 inches from mic | Speak too close (causes pops) |
| Use natural, consistent pace | Rush or speak too slowly |
| Read the full sample text | Use very short clips (<3s) |
| Use 24kHz+ sample rate | Use low quality audio |

### Verify Your Reference Audio

```bash
# Play it back
afplay my_voice.wav

# Check duration and format
ffprobe my_voice.wav 2>&1 | grep -E "Duration|Audio"
```

Target: 5-8 seconds, 24000 Hz sample rate, mono or stereo.

## Improving Audio Quality

For clearer output, use lower temperature values in Python directly:

```python
from sopro import SoproTTS

tts = SoproTTS.from_pretrained("samuel-vitorino/sopro", device="mps")

wav = tts.synthesize(
    "Your text here",
    ref_audio_path="reference.wav",
    temperature=0.8,  # Lower = clearer but less varied
    top_p=0.85
)

tts.save_wav("output.wav", wav)
```

## Quality Considerations

Sopro is a lightweight 169M parameter model - it trades quality for speed and size. This makes it:

- Fast inference, especially on Apple Silicon (MPS)
- Small model size, easy to run locally
- Good for prototyping and experimentation

For production-quality TTS with better clarity, consider these alternatives:

### Open Source Models

#### Actively Maintained (2024-2025)

| Model | Params | Size | Quality | Stars | Released | Status | Link |
|-------|--------|------|---------|-------|----------|--------|------|
| **Fish Speech** | 500M | ~1.7 GB | Excellent | 24.6k | 2024 | Apache 2.0 + paid API | [GitHub](https://github.com/fishaudio/fish-speech) |
| **Chatterbox** | 350M | ~1.5 GB | Excellent | 21k | May 2025 | MIT + paid API | [GitHub](https://github.com/resemble-ai/chatterbox) |
| **IndexTTS** | 300M | ~2.5 GB | Excellent | 16.7k | 2024 | Apache 2.0 + paid API (Fal.ai) | [GitHub](https://github.com/index-tts/index-tts) |
| **F5-TTS** | 335M | 1.35 GB | Excellent | 13.9k | Oct 2024 | MIT code, CC-BY-NC weights | [GitHub](https://github.com/SWivid/F5-TTS) |
| **Orpheus TTS** | 3B/1B/400M/150M | 12/4/1.6/0.6 GB | Very Good | 5.8k | Mar 2025 | Apache 2.0 + paid API | [GitHub](https://github.com/canopyai/Orpheus-TTS) |
| **Kokoro** | 82M | 350 MB | Good | 5.3k | Jan 2025 | Apache 2.0 + paid API | [GitHub](https://github.com/hexgrad/kokoro) |
| **Dia** | 1.6B | ~6 GB | Excellent | 4k+ | Apr 2025 | Apache 2.0 (free) | [GitHub](https://github.com/nari-labs/dia) |
| **Sesame CSM** | 1B | ~4 GB | Excellent | 3k+ | Feb 2025 | Apache 2.0 (free) | [GitHub](https://github.com/SesameAILabs/csm) |
| **Sopro** | 169M | ~650 MB | Good | 600 | Nov 2024 | Apache 2.0 (free) | [GitHub](https://github.com/samuel-vitorino/sopro) |

#### Legacy (Less Active)

| Model | Params | Size | Quality | Stars | Released | Status | Link |
|-------|--------|------|---------|-------|----------|--------|------|
| **Coqui XTTS** | 467M | 1.87 GB | Very Good | 44k | 2023 | AGPL (community maintained) | [GitHub](https://github.com/coqui-ai/TTS) |
| **Bark** | 900M+ | ~5 GB | Good | 39k | Apr 2023 | MIT (free) | [GitHub](https://github.com/suno-ai/bark) |
| **Piper** | 20-60M | 20-100 MB | Good | 10k | 2023 | MIT (free, commercial OK) | [GitHub](https://github.com/rhasspy/piper) |
| **StyleTTS 2** | 150M | ~600 MB | Excellent | 5k | Nov 2023 | MIT (free) | [GitHub](https://github.com/yl4579/StyleTTS2) |

### Proprietary / Cloud APIs

| Service | Quality | Status | Pricing | Link |
|---------|---------|--------|---------|------|
| **OpenAI GPT-4o-mini-tts** | Excellent, expressive | Active (2025) | $0.015/min | [Docs](https://platform.openai.com/docs/models/gpt-4o-mini-tts) |
| **OpenAI TTS** | Excellent | Active | $15/1M chars | [Docs](https://platform.openai.com/docs/guides/text-to-speech) |
| **xAI Grok Voice** | Real-time, conversational | Active (Dec 2025) | $0.05/min | [Docs](https://docs.x.ai/docs/guides/voice) |
| **ElevenLabs** | Very realistic | Active, popular | Free tier + paid plans | [Website](https://elevenlabs.io/) |
| **Google Cloud TTS** | Good, 220+ voices | Active | Pay per use | [Docs](https://cloud.google.com/text-to-speech) |
| **Amazon Polly** | Good | Active | Pay per use | [Docs](https://aws.amazon.com/polly/) |
| **Azure TTS** | Good, 400+ voices | Active | Pay per use | [Docs](https://azure.microsoft.com/en-us/products/ai-services/text-to-speech) |

### Translation Models

For machine translation, consider these open-source alternatives:

| Model | Params | Languages | Quality | Features | License | Links |
|-------|--------|-----------|---------|----------|---------|-------|
| **TranslateGemma** | 4B/12B/27B | 55 | Excellent | Multimodal (text in images), based on Gemma 3 | Apache 2.0 | [HuggingFace](https://huggingface.co/collections/google/translategemma) / [Kaggle](https://www.kaggle.com/models/google/translategemma) |
| **NLLB-200** | 600M-3.3B | 200+ | Very Good | Best for low-resource languages | CC BY-NC 4.0 | [Meta AI](https://ai.meta.com/research/no-language-left-behind/) / [GitHub](https://github.com/facebookresearch/fairseq/tree/nllb) |
| **MADLAD-400** | 3B-10.7B | 419 | Good | Widest language coverage, mobile-friendly | CC BY 4.0 | [Paper](https://arxiv.org/abs/2309.04662) / [GitHub](https://github.com/google-research/google-research/tree/master/madlad_400) |
| **SeamlessM4T v2** | 2.3B | ~100 | Excellent | Speech-to-speech, speech-to-text, text-to-text | CC BY-NC 4.0 | [Meta AI](https://ai.meta.com/research/seamless-communication/) / [GitHub](https://github.com/facebookresearch/seamless_communication) |

#### TranslateGemma Details

Google's new TranslateGemma (Jan 2025) is built on Gemma 3 and optimized specifically for translation:

- **4B model**: Optimized for mobile/edge devices (phones, IoT)
- **12B model**: Best efficiency/performance ratio, outperforms 27B Gemma 3 baseline
- **27B model**: Maximum fidelity, runs on single H100 GPU or TPU
- **Multimodal**: Can translate text embedded in images
- **Available on**: Kaggle, Hugging Face, Vertex AI

## Device Options

| Device | Description |
|--------|-------------|
| `cpu` | Works everywhere, slowest |
| `mps` | Apple Silicon GPU (M1/M2/M3/M4), fast |
| `cuda` | NVIDIA GPU, fast (not available on Mac) |

## Files

- `setup.sh` - Installation script (run first)
- `demo.py` - CLI demo application
- `create_reference.sh` - Interactive helper to create reference audio
- `samantha.wav` - Sample reference voice (macOS Samantha)
