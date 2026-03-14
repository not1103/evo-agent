# EvoAgent - Phase 4: Auto-Record Automation

## Auto-Record 功能

每當我完成一個 quality >= 7 既成功 task，我會：

1. **自動 detect** 呢個可能值得 record
2. **問你** 想唔想 record
3. **一鍵 record** 如果你想

## 使用方式

岩岩示範：
```
Task: coding
Problem: fixing node pairing  
Solution: manually added device entry
Quality: 8/10

要記錄呢個 solution 嗎？
```

## 觸發方法

你既時候可以話：
- "幫我 record 呢個"
- "記錄今次既 solution"
- "save this for later"

我會問你啱既 details 或者直接 record。

---

## 完整 Command List (for reference)

```
# Manual record
evo record <type> <problem> <solution> <outcome> [quality] [tags...]

# List
evo list [type]

# Suggest  
evo suggest <type> <keywords>

# Publish to marketplace
evo publish <id>

# Browse marketplace
evo marketplace list

# Stats
evo stats

# Export/Import
evo export [id]
evo import <file>
```

---

## 下一步諗法

- **Phase 5**: 整 webhook，等我可以自動 push 經驗去 GitHub
- **Phase 6**: 加 voice input，等你可以用講既方式 record
- **Phase 7**: 加入 AI-generated summaries (我用 MiniMax 幫你寫 summary)

有咩想加既？
