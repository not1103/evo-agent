# Contributing to EvoAgent

Thank you for your interest in contributing to EvoAgent! 🎉

## Ways to Contribute

### 1. Report Bugs
Found a bug? Open an issue with:
- Clear description
- Steps to reproduce
- Expected vs actual behavior

### 2. Suggest Features
Have an idea? Open an issue with:
- Clear description of the feature
- Use case / why it's useful
- Any implementation ideas (optional)

### 3. Submit Pull Requests

#### Development Setup
```bash
git clone https://github.com/not1103/evo-agent.git
cd evo-agent
chmod +x evo.sh

# Test locally
./evo.sh record test "test problem" "test solution" success 5
./evo.sh list
./evo.sh stats
```

#### Pull Request Guidelines
1. Fork the repo
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Make your changes
4. Test locally
5. Commit with clear messages
6. Push to your fork
7. Open a Pull Request

#### Code Style
- Use clear, descriptive variable names
- Add comments for complex logic
- Keep functions focused and small
- Test your changes before submitting

### 4. Share Your Experiences
- Star the repo ⭐
- Share with friends
- Write blog posts
- Create tutorials

## Project Structure

```
evo-agent/
├── evo.sh           # Main CLI application
├── evo-auto.sh      # Auto-record hook
├── evo-share.sh     # Sharing utilities
├── SKILL.md         # OpenClaw skill definition
├── README.md        # Main documentation
├── EXAMPLES.md      # Usage examples
├── index.html       # Demo website
└── CONTRIBUTING.md # This file
```

## Common Tasks

### Adding a New Command
1. Add command case in `evo.sh`
2. Update README.md with documentation
3. Add examples in EXAMPLES.md
4. Test thoroughly

### Testing
```bash
# Test all commands
./evo.sh record coding "test" "test" success 5
./evo.sh list
./evo.sh search test
./evo.sh stats

# Clean up test data
rm -rf ~/.openclaw/evo/experiences/evo_*
```

## Contact

- Issues: https://github.com/not1103/evo-agent/issues
- Discussions: https://github.com/not1103/evo-agent/discussions

---

**Thank you for helping make EvoAgent better!** 🧬
