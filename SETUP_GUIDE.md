# 🚀 Setup Guide - Your Exact Configuration

## Your System Details

- **KiCAD Version:** 9.0
- **KiCAD Location:** `C:\Program Files\KiCad\9.0\bin\kicad.exe`
- **MCP Code Location:** `C:\KiCAD-MCP-Server`
- **Claude:** Installed ✓

---

## 📋 Step-by-Step Setup (5 Minutes)

### Step 1: Build the MCP Server

Open PowerShell or Command Prompt in `C:\KiCAD-MCP-Server`:

```bash
# Install dependencies
npm install
pip install -r requirements.txt

# Build the server
npm run build
```

**✓ You should see:** `dist\server.js` created

---

### Step 2: Find Your Claude Config File

**For Claude Code:**
```
C:\Users\<YourUsername>\.claude\config\claude_desktop_config.json
```

**For Claude Desktop:**
```
C:\Users\<YourUsername>\AppData\Roaming\Claude\claude_desktop_config.json
```

**Quick way to open it:**
```bash
# In PowerShell:
notepad "$env:APPDATA\Claude\claude_desktop_config.json"

# OR for Claude Code:
notepad "$env:USERPROFILE\.claude\config\claude_desktop_config.json"
```

---

### Step 3: Add This Configuration

**Copy and paste THIS into your config file:**

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

**⚠️ Important Notes:**
- Use double backslashes `\\` in paths
- If you already have other MCP servers, add the "kicad" section inside existing "mcpServers"

**If you have other servers already:**
```json
{
  "mcpServers": {
    "existing-server": {
      ...existing config...
    },
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

---

### Step 4: Restart Claude

1. **Close Claude completely** (not just the window - exit from system tray too)
2. **Wait 3 seconds**
3. **Open Claude again**

---

### Step 5: Test It Works! 🎉

**In Claude, type one of these:**

```
List KiCAD symbol libraries
```

**OR**

```
Check if KiCAD MCP is working
```

**Expected Result:**
- You see a list of 200+ libraries = ✅ SUCCESS!
- Error message = ❌ See troubleshooting below

---

## 🔧 Troubleshooting

### Problem 1: "kicad server not found"

**Solution:** Check config file paths are correct
```bash
# Verify paths exist:
dir "C:\KiCAD-MCP-Server\dist\server.js"
dir "C:\Program Files\KiCad\9.0\bin\kicad.exe"
```

---

### Problem 2: "Python module not found"

**Solution:** Test Python can find KiCAD:
```bash
cd "C:\Program Files\KiCad\9.0\bin"
python -c "import pcbnew; print('KiCAD Python OK')"
```

If this fails, install KiCAD Python packages:
```bash
pip install pcbnew
```

---

### Problem 3: "Server crashes on startup"

**Solution:** Test server manually:
```bash
cd C:\KiCAD-MCP-Server
node dist\server.js
```

Look at error messages and fix accordingly.

---

### Problem 4: "Access denied" or "Permission error"

**Solution:** Run as administrator once:
```bash
# Right-click PowerShell -> Run as Administrator
cd C:\KiCAD-MCP-Server
npm run build
```

---

## ✅ Verification Checklist

Before asking Claude to use KiCAD, verify:

- [ ] `dist\server.js` exists in `C:\KiCAD-MCP-Server`
- [ ] Config file has correct paths with `\\` (double backslash)
- [ ] Claude was fully restarted
- [ ] Test command works: "List KiCAD symbol libraries"

---

## 🎯 Now You Can Use It!

Once setup is complete, just talk naturally to Claude:

### Example Conversations:

**Create New Project:**
```
You: Create a new KiCAD project called "MyFirstBoard"
Claude: ✓ Project created at C:\KiCAD-MCP-Server\MyFirstBoard
```

**Design a Circuit:**
```
You: Add an ESP32 and LED with resistor to the board
Claude: ✓ Components placed
You: Show me what it looks like
Claude: [Shows board preview image]
```

**Export for Manufacturing:**
```
You: Export Gerber files for this project
Claude: ✓ Gerber files exported to ./gerbers/
```

---

## 📚 What to Do Next

1. **Read the guides:**
   - `HOW_TO_USE.md` - Complete usage guide
   - `PROMPT_CHEATSHEET.md` - Quick reference
   - `EXAMPLE_SESSION.md` - Real design example

2. **Try simple commands:**
   ```
   Create a test project
   Set board size to 100mm x 80mm
   Show me the board
   ```

3. **Build something real:**
   - LED blinker circuit
   - Sensor breakout board
   - Power supply module

---

## 🎊 You're All Set!

The flow is now:

```
You type in Claude
    ↓
Claude uses KiCAD MCP Server
    ↓
Server controls KiCAD
    ↓
Result comes back to you
```

**No manual clicking in KiCAD needed!** Just describe what you want. 🚀

---

## 🆘 Still Need Help?

If you get stuck:
1. Check `TROUBLESHOOTING.md`
2. Run diagnostic: `scripts\diagnose.ps1`
3. Open issue on GitHub

---

**Happy PCB designing!** 🎨⚡
