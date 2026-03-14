# EvoAgent Examples

More examples for using EvoAgent in different scenarios.

## Basic Recording

```bash
# Record a coding solution
./evo.sh record coding "python import error" "added sys.path" success 8

# Record a writing task
./evo.sh record writing "blog post about AI" "used engaging hook" success 9 blog,ai

# Record an analysis task
./evo.sh record analysis "market research" "searched trends" success 8 research
```

## Auto-Detect

```bash
# Let EvoAgent detect the task type automatically
./evo.sh auto "fixing the database connection" "updated connection string" 9
# → Detects: coding

./evo.sh auto "writing a product description" "used persuasive language" 8
# → Detects: writing
```

## Search & Suggest

```bash
# Search for solutions
./evo.sh search "error"
./evo.sh search "gateway"
./evo.sh search "python"

# Get suggestions based on task
./evo.sh suggest "I need to fix a network issue"
# → Auto-detects type and suggests relevant solutions
```

## Sharing

```bash
# Share an experience (generates Markdown)
./evo.sh share evo_1234567890

# Export all experiences
./evo.sh export

# Import experiences from file
./evo.sh import backup.tar.gz
```

## Marketplace

```bash
# Publish to marketplace
./evo.sh publish evo_1234567890

# View marketplace
./evo.sh marketplace

# List published items
./evo.sh marketplace list
```

## API Server

```bash
# Start API server
./evo.sh api
# → Runs on http://localhost:18790

# Using the API
curl http://localhost:18790/experiences
curl http://localhost:18790/stats
curl "http://localhost:18790/search?q=gateway"
```

## Integration with OpenClaw

After installing as a skill:

```bash
# Record directly
evo record coding "bug fix" "solution" success 8

# Or use natural language - I'll understand!
# "record this solution for later"
```

## Real-World Use Cases

### Use Case 1: Bug Tracking

```bash
./evo.sh record coding "memory leak in production" "found unclosed connection in finally block" success 9 production,debug,memory
./evo.sh search "memory leak"
# → Finds similar issues
```

### Use Case 2: Content Creation

```bash
./evo.sh record writing "viral Twitter thread" "used numbered list format with hooks" success 8 social,content
./evo.sh search "Twitter"
```

### Use Case 3: Research

```bash
./evo.sh record analysis "understanding new technology" "read documentation and experimented" success 8 research,learning
./evo.sh suggest "I need to learn about blockchain"
```

### Use Case 4: System Administration

```bash
./evo.sh record general "server downtime" "restarted services and checked logs" success 9 devops,server
./evo.sh search "server"
```

## Tips

1. **Use descriptive problems**: The more specific your problem description, the better the search results.

2. **Add tags**: Tags help categorize and find experiences later.

3. **Quality scores**: Rate honestly (1-10). Higher quality (7+) experiences are prioritized in suggestions.

4. **Regular recording**: Make it a habit to record successful solutions!

## Automation

You can automate recording by adding to your workflow:

```bash
# In your shell profile
alias evo='~/path/to/evo.sh'

# After successful commands
&& evo record coding "task description" "what worked" success 8
```

---

More examples coming soon! 

Contribute your own at: https://github.com/not1103/evo-agent
