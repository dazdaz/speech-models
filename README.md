# TTS & Translation Model Comparison

A comparison of text-to-speech and translation models, with a [Sopro demo implementation](model-sopro/).

## Open Source Models

### Actively Maintained (2024-2026)

✨ [**View Interactive Comparison & Sorting**](https://htmlpreview.github.io/?https://github.com/dazdaz/speech-models/blob/main/index.html)

| Model | Params | Size | Voices | Quality | Use Case | Released | License | Link |
|-------|--------|------|--------|---------|----------|----------|---------|------|
| **Fish Speech** | 500M | ~1.7 GB | 200k+ + Clone | Excellent | General TTS, voice cloning | 2024 | Apache 2.0 | [Listen 🎵](https://speech.fish.audio/samples/) | [GitHub](https://github.com/fishaudio/fish-speech) |
| **Chatterbox** | 350M | ~1.5 GB | 0 + Clone | Excellent | Voice cloning, emotion control | May 2025 | MIT | [Listen 🎵](https://www.resemble.ai/chatterbox/) | [GitHub](https://github.com/resemble-ai/chatterbox) |
| **IndexTTS** | 300M | ~2.5 GB | 0 + Clone | Excellent | Voice cloning, Chinese/English | 2024 | Apache 2.0 | [Listen 🎵](https://index-tts.github.io/index-tts2.github.io/) | [GitHub](https://github.com/index-tts/index-tts) |
| **F5-TTS** | 335M | 1.35 GB | 0 + Clone | Excellent | Zero-shot voice cloning | Oct 2024 | MIT/CC-BY-NC | [Listen 🎵](https://swivid.github.io/F5-TTS/) | [GitHub](https://github.com/SWivid/F5-TTS) |
| **Microsoft VibeVoice** | 0.5B-7B | 2-28 GB | 4 + Clone | Excellent | Podcasts, audiobooks, multi-speaker | Aug 2025 | MIT | [Listen 🎵](https://microsoft.github.io/VibeVoice/) | [GitHub](https://github.com/microsoft/VibeVoice) |
| **Dia** | 1.6B | ~6 GB | 2 + Clone | Excellent | Dialogue, multi-speaker conversations | Apr 2025 | Apache 2.0 | [Listen 🎵](https://huggingface.co/spaces/nari-labs/Dia-1.6B) | [GitHub](https://github.com/nari-labs/dia) |
| **PersonaPlex-7B** | 7.7B | ~15 GB | 0 + Clone | Excellent | Full-duplex conversation, real-time | Mar 2025 | MIT | [Listen 🎵](https://research.nvidia.com/labs/adlr/personaplex/) | [GitHub](https://github.com/NVIDIA/personaplex) |
| **Sesame CSM** | 1B | ~4 GB | 0 + Clone | Excellent | Conversational, expressive speech | Feb 2025 | Apache 2.0 | [Listen 🎵](https://huggingface.co/spaces/sesame/csm-1b) | [GitHub](https://github.com/SesameAILabs/csm) |
| **Orpheus TTS** | 150M-3B | 0.6-12 GB | 12 + Clone | Very Good | Emotional speech, low latency | Mar 2025 | Apache 2.0 | [Listen 🎵](https://github.com/canopyai/Orpheus-TTS) | [GitHub](https://github.com/canopyai/Orpheus-TTS) |
| **Kokoro** | 82M | 350 MB | 10+ + Clone | Good | Lightweight, fast inference | Jan 2025 | Apache 2.0 | [Listen 🎵](https://huggingface.co/spaces/amphion/Kokoro-82M) | [GitHub](https://github.com/hexgrad/kokoro) |
| **Sopro** | 169M | ~650 MB | 0 + Clone | Good | Prototyping, voice cloning | Nov 2024 | Apache 2.0 | [Listen 🎵](https://github.com/samuel-vitorino/sopro) | [GitHub](https://github.com/samuel-vitorino/sopro) |
| **LuxTTS** | Unknown | < 1 GB VRAM | 0 + Clone | Excellent | High-speed voice cloning, real-time | Jan 2026 | Apache 2.0 | [Listen 🎵](https://github.com/ysharma3501/LuxTTS) | [GitHub](https://github.com/ysharma3501/LuxTTS) |
| **Qwen3-TTS** | Unknown | Unknown | Design + Clone | Excellent | Voice design, cloning, storytelling | Dec 2025 | Unknown | [Listen 🎵](https://huggingface.co/spaces/Qwen/Qwen3-TTS) | [HuggingFace](https://huggingface.co/spaces/Qwen/Qwen3-TTS) |
| **Pocket TTS** | Unknown | Small | Unknown | Good | On-device CPU inference | Jan 2026 | MIT | [Listen 🎵](https://github.com/kyutai-labs/pocket-tts) | [GitHub](https://github.com/kyutai-labs/pocket-tts) |

### Proprietary / Cloud APIs

| Service | Voices | Quality | Use Case | Pricing | Link |
|---------|--------|---------|----------|---------|------|
| **OpenAI GPT-4o-mini-tts** | 4+ | Excellent | Expressive narration, assistants | $0.015/min | [Docs](https://platform.openai.com/docs/models/gpt-4o-mini-tts) |
| **OpenAI TTS** | 6 | Excellent | General TTS, apps | $15/1M chars | [Docs](https://platform.openai.com/docs/guides/text-to-speech) |
| **ElevenLabs** | 1000+ | Excellent | Voice cloning, dubbing | Free tier + paid | [Website](https://elevenlabs.io/) |
| **xAI Grok Voice** | N/A | Very Good | Real-time conversations | $0.05/min | [Docs](https://docs.x.ai/docs/guides/voice) |
| **Google Cloud TTS** | 220+ | Good | Multilingual apps | Pay per use | [Docs](https://cloud.google.com/text-to-speech) |
| **Amazon Polly** | 60+ | Good | IVR, accessibility | Pay per use | [Docs](https://aws.amazon.com/polly/) |
| **Azure TTS** | 400+ | Good | Enterprise, multilingual | Pay per use | [Docs](https://azure.microsoft.com/en-us/products/ai-services/text-to-speech) |

### Translation Models

Open-source models for translating text between languages. These can run locally for privacy or be deployed for production use.

| Model | Params | Languages | Quality | Use Case | License | Links |
|-------|--------|-----------|---------|----------|---------|-------|
| **TranslateGemma** | 4B/12B/27B | 55 | Excellent | Image text, multimodal translation | Apache 2.0 | [HuggingFace](https://huggingface.co/collections/google/translategemma) / [Kaggle](https://www.kaggle.com/models/google/translategemma) |
| **NLLB-200** | 600M-3.3B | 200+ | Very Good | Low-resource languages | CC BY-NC 4.0 | [Meta AI](https://ai.meta.com/research/no-language-left-behind/) |
| **MADLAD-400** | 3B-10.7B | 419 | Good | Wide coverage, mobile | CC BY 4.0 | [GitHub](https://github.com/google-research/google-research/tree/master/madlad_400) |
| **SeamlessM4T v2** | 2.3B | ~100 | Excellent | Speech-to-speech, multimodal | CC BY-NC 4.0 | [GitHub](https://github.com/facebookresearch/seamless_communication) |

#### TranslateGemma Details

Google's TranslateGemma (Jan 2025) is built on Gemma 3:

- **4B**: Mobile/edge devices
- **12B**: Best efficiency/performance ratio
- **27B**: Maximum fidelity (single H100)
- **Multimodal**: Translates text in images

### Legacy (Less Active)

| Model | Params | Size | Voices | Quality | Use Case | Released | License | Link |
|-------|--------|------|--------|---------|----------|----------|---------|------|
| **Coqui XTTS** | 467M | 1.87 GB | Clone | Very Good | Multilingual voice cloning | 2023 | AGPL | [GitHub](https://github.com/coqui-ai/TTS) |
| **Bark** | 900M+ | ~5 GB | Clone | Good | Audio effects, music, laughter | Apr 2023 | MIT | [GitHub](https://github.com/suno-ai/bark) |
| **Piper** | 20-60M | 20-100 MB | 100+ | Good | Offline, embedded, Raspberry Pi | 2023 | MIT | [GitHub](https://github.com/rhasspy/piper) |
| **StyleTTS 2** | 150M | ~600 MB | Clone | Excellent | High-quality style transfer | Nov 2023 | MIT | [GitHub](https://github.com/yl4579/StyleTTS2) |

## Sopro Demo

See [model-sopro/](model-sopro/) for a working demo implementation using Sopro TTS.
