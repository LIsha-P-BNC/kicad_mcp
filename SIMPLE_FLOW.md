# Simple Flow - How Everything Works

## 🎯 What You Have

```
┌─────────────────────────┐
│   YOUR COMPUTER         │
│                         │
│  ✓ KiCAD 9.0           │ ← Installed at C:\Program Files\KiCad\9.0
│  ✓ Claude               │ ← Your AI assistant
│  ✓ MCP Code (from git) │ ← At C:\KiCAD-MCP-Server
│                         │
└─────────────────────────┘
```

---

## 🔗 How to Connect Them

### The 3-Step Connection:

```
STEP 1: Build MCP Server
┌────────────────────────┐
│  C:\KiCAD-MCP-Server   │
│                        │
│  npm install           │ ← Get dependencies
│  npm run build         │ ← Create dist/server.js
│                        │
│  Result: ✓ server.js   │ ← This is the "bridge"!
└────────────────────────┘


STEP 2: Tell Claude About MCP
┌────────────────────────┐
│  Claude Config File    │
│                        │
│  Add this:             │
│  {                     │
│    "mcpServers": {     │
│      "kicad": {        │
│        "command": ..   │ ← Points to server.js
│      }                 │
│    }                   │
│  }                     │
└────────────────────────┘


STEP 3: Restart Claude
┌────────────────────────┐
│  Close Claude          │
│  Wait 3 seconds        │
│  Open Claude           │
│                        │
│  ✓ MCP auto-connects!  │
└────────────────────────┘
```

---

## 💬 How It Works When You Use It

```
YOU                    CLAUDE                 MCP SERVER              KICAD
│                       │                      │                       │
│ "Create PCB"          │                      │                       │
├──────────────────────>│                      │                       │
│                       │ Call MCP tool        │                       │
│                       ├─────────────────────>│                       │
│                       │                      │ Run Python script     │
│                       │                      ├──────────────────────>│
│                       │                      │                       │
│                       │                      │  ✓ Project created    │
│                       │                      │<──────────────────────┤
│                       │  ✓ Done!             │                       │
│                       │<─────────────────────┤                       │
│  "✓ Created PCB"      │                      │                       │
│<──────────────────────┤                      │                       │
│                       │                      │                       │
```

**Timeline:** This all happens in ~1 second!

---

## 📂 File Structure (What You Need to Know)

```
C:\KiCAD-MCP-Server\
│
├── dist\
│   └── server.js          ← THIS IS THE IMPORTANT FILE!
│                             Claude calls this to use KiCAD
│
├── python\
│   └── kicad_interface.py ← This talks to KiCAD API
│
├── package.json           ← Lists what npm install needs
├── requirements.txt       ← Lists what pip install needs
│
└── Documentation:
    ├── SETUP_GUIDE.md     ← Read this FIRST! (exact config for you)
    ├── HOW_TO_USE.md      ← Examples and tutorials
    └── PROMPT_CHEATSHEET.md ← Quick commands
```

---

## 🎬 Real Usage Example

### Before Setup:
```
You: Create a PCB project
Claude: ❌ I can't control KiCAD directly
```

### After Setup:
```
You: Create a PCB project called "Test"
Claude: ✓ Created project at C:\KiCAD-MCP-Server\Test
        Files: Test.kicad_pro, Test.kicad_pcb, Test.kicad_sch

You: Set board size to 100x80mm
Claude: ✓ Board size set to 100mm x 80mm

You: Place an LED at position (50, 40)mm
Claude: ✓ LED placed at (50, 40)mm on F.Cu layer

You: Show me the board
Claude: [Shows PNG image of your board]
```

**That's it!** No clicking around in KiCAD. Just talk!

---

## 🔄 Complete Flow Diagram

```
┌──────────────────────────────────────────────────────────────┐
│                     YOUR WORKFLOW                            │
└──────────────────────────────────────────────────────────────┘
                              │
                              ▼
                    ┌──────────────────┐
                    │  1. You type in  │
                    │     Claude       │
                    └────────┬─────────┘
                             │
                             ▼
                    ┌──────────────────┐
                    │  2. Claude sends │
                    │     to MCP       │
                    └────────┬─────────┘
                             │
                             ▼
                    ┌──────────────────┐
                    │  3. MCP Server   │
                    │  (dist/server.js)│
                    └────────┬─────────┘
                             │
                             ▼
                    ┌──────────────────┐
                    │  4. Python runs  │
                    │  (kicad_api)     │
                    └────────┬─────────┘
                             │
                             ▼
                    ┌──────────────────┐
                    │  5. KiCAD does   │
                    │     the work     │
                    └────────┬─────────┘
                             │
                             ▼
                    ┌──────────────────┐
                    │  6. Result back  │
                    │     to you!      │
                    └──────────────────┘
```

---

## ⚙️ Configuration File (Exact Copy for You)

**Location:**
```
C:\Users\<YourName>\.claude\config\claude_desktop_config.json
```

**Content (copy this EXACTLY):**
```json
{
  "mcpServers": {
    "kicad": {
      "command": "node",
      "args": [
        "C:\\KiCAD-MCP-Server\\dist\\server.js"
      ],
      "env": {
        "KICAD_PATH": "C:\\Program Files\\KiCad\\9.0\\bin",
        "PYTHONPATH": "C:\\Program Files\\KiCad\\9.0\\bin\\Lib\\site-packages"
      }
    }
  }
}
```

**Key points:**
- Use `\\` (double backslash) not `\`
- Path points to YOUR `server.js`
- KiCAD version is 9.0 (not 8.0)

---

## ✅ Quick Test After Setup

**Type this in Claude:**
```
List KiCAD symbol libraries
```

**If working, you'll see:**
```
Found 223 symbol libraries:
- Device
- MCU_Espressif
- MCU_ST_STM32F1
- Connector
- ...
```

**If not working:**
- Check config file paths
- Restart Claude completely
- See SETUP_GUIDE.md troubleshooting section

---

## 🎓 Learning Path

1. **Day 1:** Setup (follow SETUP_GUIDE.md)
2. **Day 2:** Try simple commands (PROMPT_CHEATSHEET.md)
3. **Day 3:** Design your first board (EXAMPLE_SESSION.md)
4. **Day 4+:** Build real projects!

---

## 💡 Remember

**You don't need to:**
- Open KiCAD manually
- Click menus
- Learn KiCAD shortcuts
- Know where features are

**You just:**
- Type what you want
- Claude makes it happen
- KiCAD does the work

---

## 🚀 Summary: 3 Commands to Get Started

```bash
# 1. Build
npm run build

# 2. Configure (edit config file with paths above)

# 3. Restart Claude and test
"List KiCAD symbol libraries"
```

**That's all!** Simple, right? 😊

---

**Next step:** Follow SETUP_GUIDE.md for detailed instructions!
