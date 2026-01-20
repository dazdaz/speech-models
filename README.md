# TTS & Translation Model Comparison

A comparison of text-to-speech and translation models, with a demo implementation using [Sopro](model-sopro/).

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
| **Microsoft VibeVoice** | 0.5B/1.5B/7B | 2-28 GB | Excellent | 10k+ | Aug 2025 | MIT (free) | [GitHub](https://github.com/microsoft/VibeVoice) |
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

## Sopro Demo

See [model-sopro/](model-sopro/) for a working demo implementation using Sopro TTS.
