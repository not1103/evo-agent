# EvoAgent - Phase 3: 自動化與 API

呢個 phase 我哋會整：

1. **Auto-prompt**: 每次完成好既 task 之後，我自動問用戶使唔使 record
2. **API Server**: 整一個簡單既 HTTP server，等其他agent可以access
3. **Better Integration**: 令我可以直接 call evo commands

## Auto-Prompt 機制

每次我完成以下類型既 task，我會自動問：
- "要唔要記錄呢個 solution 以後用？"

## API Server (optional)

如果要整既話，可以加：
```bash
# 啟動 API
evo api

# 其他 agent 可以：
curl http://localhost:18790/evo/suggest?type=coding&keywords=gateway
```

---

## 當前使用方式

你可以直接叫我：

- **記錄經驗**: "帮我 record 呢個"
- **睇經驗**: "show me previous experiences"  
- **建議**: "之前點樣解决呢個問題"
- **發佈**: "publish 呢個经验"
- **統計**: "show evo stats"
