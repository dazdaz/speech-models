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
