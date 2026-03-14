# EvoAgent v0.6 - AI Experience Evolution System

一個類似 EvoMap GEP Protocol 既開源系統，令 AI Agent 可以記錄、共享、同埋進化。

## Features

| Feature | Description |
|---------|-------------|
| **Record** | 記錄成功既經驗 (Gene + Capsule + AI Summary) |
| **Search** | 語義搜索 - 基於關鍵詞matching |
| **Suggest** | 根據當前任務建議解決方案 |
| **AI Summary** | 自動生成 solution summary |
| **Publish** | 發佈到本地 marketplace |
| **Share** | 導出為 GitHub Gist 格式 |
| **Stats** | 追蹤成功率和質量 |

## Usage

```bash
# Record a new experience
evo record <type> <problem> <solution> <outcome> [quality] [tags...]

# List all experiences
evo list [type]

# Semantic search
evo search <query>

# Get suggestions
evo suggest <type> <keywords>

# Share (with AI summary)
evo share <id>

# Publish to marketplace
evo publish <id>

# View marketplace
evo marketplace

# Stats
evo stats
```

## Examples

```bash
# Record a coding solution
evo record coding "fix gateway pairing" "removed paired.json and manually added entry" success 8 bug,network

# Search for solutions
evo search "node connection error"

# Get shareable content
evo share evo_1234567890
```

## Data Location

- Experiences: `~/.openclaw/evo/experiences/`
- Genes: `~/.openclaw/evo/genes/`
- Capsules: `~/.openclaw/evo/capsules/`
- Marketplace: `~/.openclaw/evo/marketplace/`

## Version History

- **v0.1**: Basic record/list/suggest
- **v0.2**: Tags, keyword matching, marketplace, stats
- **v0.3**: Skill integration
- **v0.4**: Auto-record automation
- **v0.5**: Share & export
- **v0.6**: Semantic search & AI summary
