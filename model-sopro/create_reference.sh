#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

echo "=== Reference Audio Creator ==="
echo ""
echo "This script creates a reference audio file for voice cloning."
echo "You can either record your own voice or use a macOS system voice."
echo ""

PS3="Select option: "
options=("Record my voice" "Use macOS voice" "Quit")
select opt in "${options[@]}"; do
    case $opt in
        "Record my voice")
            echo ""
            echo "=== Recording Instructions ==="
            echo ""
            echo "For best results, read this text naturally (takes about 5-8 seconds):"
            echo ""
            echo "  \"The quick brown fox jumps over the lazy dog."
            echo "   Pack my box with five dozen liquor jugs.\""
            echo ""
            echo "Tips:"
            echo "  - Speak clearly at your normal pace"
            echo "  - Use a quiet room with no background noise"
            echo "  - Keep the microphone 6-12 inches from your mouth"
            echo "  - Avoid pops and clicks"
            echo ""
            read -p "Press Enter when ready to record (5 seconds)..."
            echo ""
            echo "Recording in 3..."
            sleep 1
            echo "2..."
            sleep 1
            echo "1..."
            sleep 1
            echo "Recording NOW! Read the text above."
            
            # Record using sox if available, otherwise use macOS rec
            if command -v rec &> /dev/null; then
                rec -r 24000 -c 1 my_voice.wav trim 0 6
            elif command -v sox &> /dev/null; then
                sox -d -r 24000 -c 1 my_voice.wav trim 0 6
            else
                # Fallback: use ffmpeg with default audio input
                ffmpeg -y -f avfoundation -i ":0" -t 6 -ar 24000 -ac 1 my_voice.wav 2>/dev/null
            fi
            
            echo ""
            echo "Recording saved to: my_voice.wav"
            echo ""
            echo "Test with:"
            echo "  afplay my_voice.wav"
            echo ""
            echo "Use for TTS:"
            echo "  ./demo.py -t 'Your text' -r my_voice.wav -o output.mp3 --device mps --temp 0.8"
            echo ""
            echo "Play output:"
            echo "  afplay output.mp3                # Normal volume"
            echo "  afplay -v 0.5 output.mp3         # 50% volume"
            echo "  afplay -v 2 output.mp3           # 2x volume (louder)"
            break
            ;;
        "Use macOS voice")
            echo ""
            echo "Available voices:"
            echo ""
            say -v "?" | grep -E "en_US|en_GB" | head -10
            echo ""
            read -p "Enter voice name (default: Samantha): " voice_name
            voice_name=${voice_name:-Samantha}
            
            output_file=$(echo "$voice_name" | tr '[:upper:]' '[:lower:]').wav
            
            echo ""
            echo "Creating reference with $voice_name voice..."
            
            say -v "$voice_name" -o temp_voice.aiff "The quick brown fox jumps over the lazy dog. Pack my box with five dozen liquor jugs."
            ffmpeg -y -i temp_voice.aiff -ar 24000 "$output_file" 2>/dev/null
            rm -f temp_voice.aiff
            
            echo "Saved to: $output_file"
            echo ""
            echo "Test with:"
            echo "  afplay $output_file"
            echo ""
            echo "Use for TTS:"
            echo "  ./demo.py -t 'Your text' -r $output_file -o output.mp3 --device mps --temp 0.8"
            echo ""
            echo "Play output:"
            echo "  afplay output.mp3                # Normal volume"
            echo "  afplay -v 0.5 output.mp3         # 50% volume"
            echo "  afplay -v 2 output.mp3           # 2x volume (louder)"
            break
            ;;
        "Quit")
            break
            ;;
        *) 
            echo "Invalid option"
            ;;
    esac
done
