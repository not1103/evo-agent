#!/bin/bash
# EvoAgent - Auto-Record Hook

# 呢個 script 會自動 detect 好既 task outcome 並建議 record

AUTO_FILE="$HOME/.openclaw/evo/.auto_record_pending"

# Check if there's a pending auto-record request
if [ -f "$AUTO_FILE" ]; then
    PENDING=$(cat "$AUTO_FILE")
    rm "$AUTO_FILE"
    echo "📝 Auto-record pending:"
    echo "$PENDING"
    echo ""
    echo "要 record 呢個經驗嗎？"
    echo "用法: evo record $PENDING"
    exit 0
fi

# Check arguments
CMD=$1

# 如果用緊 flag --auto，就進入自動模式
if [ "$CMD" = "--auto" ]; then
    TASK_TYPE=$2
    PROBLEM=$3
    SOLUTION=$4
    OUTCOME=$5
    QUALITY=${6:-7}
    
    # 咁嘅情況先建議 record:
    # - outcome = success
    # - quality >= 7
    # - 係複雜既 task (coding/analysis/creative)
    
    if [ "$OUTCOME" = "success" ] && [ $QUALITY -ge 7 ]; then
        echo "🎯 Good outcome detected! Suggesting to record..."
        echo ""
        echo "Task: $TASK_TYPE"
        echo "Problem: $PROBLEM"
        echo "Solution: $SOLUTION"
        echo "Quality: $QUALITY/10"
        echo ""
        echo "要記錄呢個 solution 嗎？"
        echo ""
        echo "如果係既，copy 以下 command:"
        echo "evo record $TASK_TYPE '$PROBLEM' '$SOLUTION' success $QUALITY"
        
        # Save to pending file for next run
        echo "$TASK_TYPE '$PROBLEM' '$SOLUTION' success $QUALITY" > "$AUTO_FILE"
    else
        echo "Outcome: $OUTCOME, Quality: $QUALITY/10"
        echo "呢個 case 未必值得 record (success + quality >= 7 先會建議)"
    fi
    exit 0
fi

# Normal evo command passthrough
EVO_SCRIPT="$HOME/.openclaw/workspace/skills/evo-agent/evo.sh"

if [ -f "$EVO_SCRIPT" ]; then
    exec "$EVO_SCRIPT" "$@"
else
    echo "❌ EvoAgent script not found: $EVO_SCRIPT"
    exit 1
fi
