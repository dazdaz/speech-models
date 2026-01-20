# TTS & Translation Model Comparison

A comparison of text-to-speech and translation models, with a [Sopro demo implementation](model-sopro/).

## Open Source Models

### Actively Maintained (2024-2025)

| Model | Params | Size | Voices | Quality | Use Case | Released | License | Link |
|-------|--------|------|--------|---------|----------|----------|---------|------|
| **Fish Speech** | 500M | ~1.7 GB | Clone | Excellent | General TTS, voice cloning | 2024 | Apache 2.0 | [GitHub](https://github.com/fishaudio/fish-speech) |
| **Chatterbox** | 350M | ~1.5 GB | Clone | Excellent | Voice cloning, emotion control | May 2025 | MIT | [GitHub](https://github.com/resemble-ai/chatterbox) |
| **IndexTTS** | 300M | ~2.5 GB | Clone | Excellent | Voice cloning, Chinese/English | 2024 | Apache 2.0 | [GitHub](https://github.com/index-tts/index-tts) |
| **F5-TTS** | 335M | 1.35 GB | Clone | Excellent | Zero-shot voice cloning | Oct 2024 | MIT/CC-BY-NC | [GitHub](https://github.com/SWivid/F5-TTS) |
| **Microsoft VibeVoice** | 0.5B-7B | 2-28 GB | 4 | Excellent | Podcasts, audiobooks, multi-speaker | Aug 2025 | MIT | [GitHub](https://github.com/microsoft/VibeVoice) |
| **Orpheus TTS** | 150M-3B | 0.6-12 GB | 12 | Very Good | Emotional speech, low latency | Mar 2025 | Apache 2.0 | [GitHub](https://github.com/canopyai/Orpheus-TTS) |
| **Dia** | 1.6B | ~6 GB | 2 | Excellent | Dialogue, multi-speaker conversations | Apr 2025 | Apache 2.0 | [GitHub](https://github.com/nari-labs/dia) |
| **Sesame CSM** | 1B | ~4 GB | Clone | Excellent | Conversational, expressive speech | Feb 2025 | Apache 2.0 | [GitHub](https://github.com/SesameAILabs/csm) |
| **Kokoro** | 82M | 350 MB | 10+ | Good | Lightweight, fast inference | Jan 2025 | Apache 2.0 | [GitHub](https://github.com/hexgrad/kokoro) |
| **Sopro** | 169M | ~650 MB | Clone | Good | Prototyping, voice cloning | Nov 2024 | Apache 2.0 | [GitHub](https://github.com/samuel-vitorino/sopro) |

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
