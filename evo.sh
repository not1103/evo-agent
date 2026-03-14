#!/bin/bash
# EvoAgent v0.7 - API Server & Enhanced Features

EVO_DIR="$HOME/.openclaw/evo"
EXPERIENCES_DIR="$EVO_DIR/experiences"
GENES_DIR="$EVO_DIR/genes"
CAPSULES_DIR="$EVO_DIR/capsules"
API_PORT=${EVO_API_PORT:-18790}

mkdir -p "$EXPERIENCES_DIR" "$GENES_DIR" "$CAPSULES_DIR"

CMD=$1
shift

generate_id() { echo "evo_$(date +%s)_$RANDOM"; }

# Get all experiences as JSON
get_experiences_json() {
    echo "["
    FIRST=1
    for dir in "$EXPERIENCES_DIR"/evo_*; do
      [ -d "$dir" ] || continue
      ID=$(basename "$dir")
      EVENT="$dir/event.json"
      [ -f "$EVENT" ] || continue
      
      if [ $FIRST -eq 0 ]; then echo ","; fi
      FIRST=0
      python3 -c "
import json
try:
    with open('$EVENT') as f:
        print(json.dumps(json.load(f)), end='')
except: pass
" 2>/dev/null
    done
    echo "]"
}

# Auto-detect task type
detect_type() {
    TEXT="$1"
    LOWER=$(echo "$TEXT" | tr '[:upper:]' '[:lower:]')
    
    case "$LOWER" in
        *code*|*bug*|*fix*|*error*|*function*|*script*|*programming*)
            echo "coding";;
        *write*|*post*|*blog*|*article*|*content*|*tweet*)
            echo "writing";;
        *analy*|*research*|*find*|*search*|*investigate*)
            echo "analysis";;
        *design*|*image*|*art*|*creative*|*video*)
            echo "creative";;
        *)
            echo "general";;
    esac
}

case $CMD in
  api)
    # Start simple HTTP API server
    echo "🚀 Starting EvoAgent API Server on port $API_PORT..."
    echo ""
    echo "Endpoints:"
    echo "  GET  /experiences     - List all"
    echo "  GET  /experience/:id - Get one"
    echo "  POST /record          - Record new"
    echo "  GET  /search?q=       - Search"
    echo "  GET  /stats           - Stats"
    echo ""
    echo "Press Ctrl+C to stop"
    
    # Create Python API server
    cat > /tmp/evo_api.py << 'PYEOF'
import http.server
import json
import os
import urllib.parse

PORT = int(os.environ.get('EVO_API_PORT', 18790))
EVO_DIR = os.path.expanduser("~/.openclaw/evo")
EXPERIENCES_DIR = os.path.join(EVO_DIR, "experiences")

class EvoHandler(http.server.BaseHTTPRequestHandler):
    def do_GET(self):
        if self.path == "/experiences":
            self.send_response(200)
            self.send_header("Content-Type", "application/json")
            self.end_headers()
            experiences = []
            for eid in os.listdir(EXPERIENCES_DIR):
                ef = os.path.join(EXPERIENCES_DIR, eid, "event.json")
                if os.path.isfile(ef):
                    try:
                        with open(ef) as f:
                            experiences.append(json.load(f))
                    except: pass
            self.wfile.write(json.dumps(experiences, indent=2).encode())
        
        elif self.path == "/stats":
            self.send_response(200)
            self.send_header("Content-Type", "application/json")
            self.end_headers()
            total = len([d for d in os.listdir(EXPERIENCES_DIR) if os.path.isdir(os.path.join(EXPERIENCES_DIR, d))])
            success = 0
            for eid in os.listdir(EXPERIENCES_DIR):
                ef = os.path.join(EXPERIENCES_DIR, eid, "event.json")
                if os.path.isfile(ef):
                    try:
                        with open(ef) as f:
                            if json.load(f).get("outcome") == "success":
                                success += 1
                    except: pass
            self.wfile.write(json.dumps({"total": total, "success": success, "rate": f"{(success*100)//(total+1)}%"}).encode())
        
        elif self.path.startswith("/experience/"):
            eid = self.path.split("/")[-1]
            ef = os.path.join(EXPERIENCES_DIR, eid, "event.json")
            if os.path.isfile(ef):
                self.send_response(200)
                self.send_header("Content-Type", "application/json")
                self.end_headers()
                with open(ef) as f:
                    self.wfile.write(json.dumps(json.load(f), indent=2).encode())
            else:
                self.send_response(404)
                self.end_headers()
        
        elif "/search" in self.path:
            query = urllib.parse.parse_qs(urllib.parse.urlparse(self.path).query).get("q", [""])[0].lower()
            results = []
            for eid in os.listdir(EXPERIENCES_DIR):
                ef = os.path.join(EXPERIENCES_DIR, eid, "event.json")
                if os.path.isfile(ef):
                    try:
                        with open(ef) as f:
                            data = json.load(f)
                            if query in data.get("problem", "").lower() or query in data.get("solution", "").lower():
                                results.append(data)
                    except: pass
            self.send_response(200)
            self.send_header("Content-Type", "application/json")
            self.end_headers()
            self.wfile.write(json.dumps(results, indent=2).encode())
        
        else:
            self.send_response(404)
            self.end_headers()
    
    def do_POST(self):
        if self.path == "/record":
            length = int(self.headers.get('Content-Length', 0))
            body = self.rfile.read(length)
            try:
                data = json.loads(body)
                eid = f"evo_{data.get('timestamp', int(__import__('time').time()))}"
                os.makedirs(os.path.join(EXPERIENCES_DIR, eid), exist_ok=True)
                with open(os.path.join(EXPERIENCES_DIR, eid, "event.json"), "w") as f:
                    json.dump({**data, "id": eid}, f, indent=2)
                self.send_response(200)
                self.send_header("Content-Type", "application/json")
                self.end_headers()
                self.wfile.write(json.dumps({"status": "ok", "id": eid}).encode())
            except Exception as e:
                self.send_response(400)
                self.end_headers()
                self.wfile.write(json.dumps({"error": str(e)}).encode())
        else:
            self.send_response(404)
            self.end_headers()

print(f"EvoAgent API running on http://localhost:{PORT}")
httpd = http.server.HTTPServer(("", PORT), EvoHandler)
httpd.serve_forever()
PYEOF
    
    EVO_API_PORT=$API_PORT python3 /tmp/evo_api.py
    ;;

  record)
    # Auto-detect type if not provided
    if [ "$1" = "--auto" ]; then
        TEXT="$2"
        SOLUTION=$3
        OUTCOME=$4
        QUALITY=${5:-7}
        TASK_TYPE=$(detect_type "$TEXT")
        PROBLEM="$TEXT"
        TAGS="auto"
    else
        TASK_TYPE=$1; PROBLEM=$2; SOLUTION=$3; OUTCOME=$4; QUALITY=${5:-7}; shift 5; TAGS="$@"
    fi
    
    ID=$(generate_id); TIMESTAMP=$(date +%s)
    mkdir -p "$EXPERIENCES_DIR/$ID"
    
    # Save Event
    cat > "$EXPERIENCES_DIR/$ID/event.json" << EOF
{
  "id": "$ID",
  "timestamp": $TIMESTAMP,
  "task_type": "$TASK_TYPE",
  "problem": "$PROBLEM",
  "solution": "$SOLUTION",
  "outcome": "$OUTCOME",
  "quality_score": $QUALITY,
  "tags": "$TAGS",
  "times_used": 0
}
EOF
    echo "✅ Recorded: $ID | Type: $TASK_TYPE | Quality: $QUALITY/10"
    ;;

  auto)
    # Quick auto-record with auto-detect
    shift
    TEXT="$1"
    SOLUTION="$2"
    QUALITY=${3:-7}
    $0 record --auto "$TEXT" "$SOLUTION" "success" $QUALITY
    ;;

  list)
    get_experiences_json | python3 -m json.tool 2>/dev/null || echo "No experiences yet"
    ;;

  search)
    QUERY="$1"
    echo "🔍 Search: $QUERY"
    QUERY_LOW=$(echo "$QUERY" | tr '[:upper:]' '[:lower:]')
    
    for dir in "$EXPERIENCES_DIR"/evo_*; do
      [ -d "$dir" ] || continue
      ID=$(basename "$dir")
      EVENT="$dir/event.json"
      [ -f "$EVENT" ] || continue
      
      PROB=$(python3 -c "import json; print(json.load(open('$EVENT')).get('problem','').lower())" 2>/dev/null)
      SOL=$(python3 -c "import json; print(json.load(open('$EVENT')).get('solution','').lower())" 2>/dev/null)
      
      if echo "$PROB $SOL" | grep -qi "$QUERY"; then
        QUAL=$(python3 -c "import json; print(json.load(open('$EVENT')).get('quality_score','-'))" 2>/dev/null)
        echo "• $ID | ⭐$QUAL"
        echo "  Problem: $PROB"
      fi
    done
    ;;

  suggest)
    TEXT="$1"
    TYPE=$(detect_type "$TEXT")
    echo "💡 Suggested (detected: $TYPE)"
    $0 search "$TEXT"
    ;;

  stats)
    TOTAL=$(ls -d "$EXPERIENCES_DIR"/evo_* 2>/dev/null | wc -l)
    SUCCESS=$(grep -r '"outcome": "success"' "$EXPERIENCES_DIR" 2>/dev/null | wc -l)
    echo "📊 EvoAgent v0.7"
    echo "Total: $TOTAL | Success: $SUCCESS"
    ;;

  help|*)
    echo "EvoAgent v0.7 - API + Auto-Detect"
    echo "=================================="
    echo "  evo api                 - 啟動 HTTP API Server (port $API_PORT)"
    echo "  evo record <type> <prob> <sol> <out> [q] [tags...]"
    echo "  evo auto <text> <solution> [quality]  - 自動偵測類型"
    echo "  evo list                            - JSON list"
    echo "  evo search <query>                  - 搜尋"
    echo "  evo suggest <text>                  - 自動偵測+建議"
    echo "  evo stats                           - 統計"
    ;;
esac
