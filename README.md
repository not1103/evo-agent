# EvoAgent 🧬

> Open-source AI Agent Experience Evolution System - Built on OpenClaw

Inspired by [EvoMap](https://evomap.ai), EvoAgent is an open-source system that enables AI agents to record, share, and evolve through collective intelligence.

## Why EvoAgent?

Currently, AI agents independently rediscover the same solutions, wasting compute and time. EvoAgent solves this by enabling:

- **Experience Recording**: Save successful solutions as Gene + Capsule bundles
- **Smart Matching**: Semantic search to find relevant past solutions
- **Knowledge Sharing**: Publish and share experiences with other agents
- **Continuous Evolution**: Learn from collective intelligence

## Features

| Feature | Description |
|---------|-------------|
| **Record** | Save solutions with auto-detected task types |
| **Search** | Semantic search across all experiences |
| **Suggest** | Get AI-powered solution suggestions |
| **Share** | Export as GitHub Gist format |
| **API** | HTTP API for agent integration |
| **Marketplace** | Local experience marketplace |

## Quick Start

**🌐 Try Online Demo**: [evo-agent-demo.netlify.app](https://evo-agent-demo.netlify.app) (coming soon)

```bash
# Clone or download
git clone https://github.com/not1103/evo-agent.git
cd evo-agent

# Make executable
chmod +x evo.sh

# Record an experience
./evo.sh record coding "fix gateway pairing" "removed paired.json and added entry" success 8

# Search for solutions
./evo.sh search "gateway error"

# Start API server
./evo.sh api
```

## Commands

```bash
./evo.sh record <type> <problem> <solution> <outcome> [quality] [tags...]
./evo.sh list
./evo.sh search <query>
./evo.sh suggest <task_description>
./evo.sh share <experience_id>
./evo.sh publish <experience_id>
./evo.sh marketplace
./evo.sh stats
./evo.sh api
```

## Examples

```bash
# Record a coding solution
./evo.sh record coding "python error" "added try-catch" success 8 bug,python

# Auto-detect task type
./evo.sh auto "fixing network issue" "restarted service" 9

# Search
./evo.sh search "gateway"

# Get shareable content
./evo.sh share evo_1234567890
```

## API Endpoints

When running `./evo.sh api`:

| Endpoint | Method | Description |
|----------|--------|-------------|
| `/experiences` | GET | List all experiences |
| `/experience/:id` | GET | Get single experience |
| `/search?q=` | GET | Search experiences |
| `/stats` | GET | Get statistics |
| `/record` | POST | Record new experience |

## Architecture

```
~/.openclaw/evo/
├── experiences/    # All recorded experiences
│   └── evo_XXX/
│       └── event.json
├── genes/         # Strategy/approach documents
├── capsules/       # Implementation details
└── marketplace/   # Shared experiences
```

## Concept: Gene + Capsule

Inspired by EvoMap's GEP Protocol:

- **Gene**: The strategy/approach to solving a problem
- **Capsule**: The actual implementation/prompt
- **Experience**: Gene + Capsule + metadata

## Tech Stack

- **Shell**: Core CLI
- **Python**: API server
- **JSON**: Data storage
- **OpenClaw**: Integration platform

## Roadmap

- [x] v0.1: Basic record/list/suggest
- [x] v0.2: Tags, marketplace, stats
- [x] v0.3: Skill integration
- [x] v0.4: Auto-prompt
- [x] v0.5: Share & export
- [x] v0.6: Semantic search
- [x] v0.7: API server & auto-detect
- [ ] v1.0: Remote marketplace sync

## Contributing

Contributions welcome! This is an open experiment in AI agent evolution.

## License

MIT

## Author

Built with 🤖 by [Your Name] using OpenClaw
