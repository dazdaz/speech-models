#!/Users/aicoder/src/model-sopro/.venv/bin/python
import argparse
import subprocess
import sys
import tempfile
from pathlib import Path

EXAMPLES = """
Examples:
  ./demo.py -t "Hello world" -r samantha.wav             # Basic synthesis
  ./demo.py -t "Hello" -r samantha.wav -o out.mp3        # Output as MP3
  ./demo.py -t "Hello" -r samantha.wav --device mps      # Use Apple Silicon GPU
  ./demo.py -t "Hello" -r samantha.wav --temp 0.8        # Clearer output (lower temp)
  ./demo.py -t "Hello" -r samantha.wav --stream          # Streaming mode

Note:
  The reference audio should be a clear speech sample (3-10 seconds).
  The output will clone the voice characteristics from this reference.
  Lower temperature (0.7-0.9) = clearer but less varied speech.
"""

def convert_to_mp3(wav_path, mp3_path):
    try:
        subprocess.run(
            ["ffmpeg", "-y", "-i", wav_path, "-codec:a", "libmp3lame", "-q:a", "2", mp3_path],
            check=True, capture_output=True
        )
        return True
    except (subprocess.CalledProcessError, FileNotFoundError):
        return False

def main():
    parser = argparse.ArgumentParser(
        description="Sopro TTS - Text to Speech with voice cloning",
        epilog=EXAMPLES,
        formatter_class=argparse.RawDescriptionHelpFormatter
    )
    parser.add_argument(
        "--text", "-t",
        default="Hello! Welcome to Sopro, a lightweight text to speech model.",
        help="Text to synthesize (default: demo greeting)"
    )
    parser.add_argument(
        "--ref", "-r",
        default="samantha.wav",
        help="Reference audio file for voice cloning (WAV/MP3, 3-10s of speech)"
    )
    parser.add_argument(
        "--output", "-o",
        default="output.wav",
        help="Output audio file path (.wav or .mp3)"
    )
    parser.add_argument(
        "--device", "-d",
        default="cpu",
        choices=["cpu", "cuda", "mps"],
        help="Compute device: cpu, cuda (NVIDIA), or mps (Apple Silicon)"
    )
    parser.add_argument(
        "--temp", "--temperature",
        type=float,
        default=1.05,
        help="Temperature (0.7-1.2). Lower = clearer, higher = more varied (default: 1.05)"
    )
    parser.add_argument(
        "--top-p",
        type=float,
        default=0.9,
        help="Top-p sampling (0.0-1.0). Lower = more focused (default: 0.9)"
    )
    parser.add_argument(
        "--stream", "-s",
        action="store_true",
        help="Enable streaming mode (generates audio in chunks)"
    )
    
    if len(sys.argv) == 1:
        parser.print_help()
        print("\nRun with -t 'your text' to synthesize speech.")
        return

    args = parser.parse_args()

    if not Path(args.ref).exists():
        print(f"Error: Reference audio not found: {args.ref}")
        print("Provide a WAV/MP3 file with clear speech (3-10 seconds).")
        print("Example: ./demo.py -t 'Hello' -r my_voice.wav")
        sys.exit(1)

    from sopro import SoproTTS

    print(f"Loading model on {args.device}...")
    tts = SoproTTS.from_pretrained("samuel-vitorino/sopro", device=args.device)

    print(f"Synthesizing: {args.text[:60]}{'...' if len(args.text) > 60 else ''}")
    
    if args.stream:
        import torch
        chunks = []
        for chunk in tts.stream(args.text, ref_audio_path=args.ref):
            chunks.append(chunk.cpu())
            print(".", end="", flush=True)
        print()
        wav = torch.cat(chunks, dim=-1)
    else:
        wav = tts.synthesize(
            args.text,
            ref_audio_path=args.ref,
            temperature=args.temp,
            top_p=args.top_p
        )

    output_path = Path(args.output)
    
    if output_path.suffix.lower() == ".mp3":
        with tempfile.NamedTemporaryFile(suffix=".wav", delete=False) as tmp:
            tmp_wav = tmp.name
        tts.save_wav(tmp_wav, wav)
        if convert_to_mp3(tmp_wav, str(output_path)):
            Path(tmp_wav).unlink()
            print(f"Saved to {output_path}")
        else:
            Path(tmp_wav).rename(output_path.with_suffix(".wav"))
            print(f"ffmpeg not found, saved as {output_path.with_suffix('.wav')}")
    else:
        tts.save_wav(str(output_path), wav)
        print(f"Saved to {output_path}")

if __name__ == "__main__":
    main()
