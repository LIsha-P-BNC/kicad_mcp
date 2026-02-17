# 📦 KiCAD MCP Server - Complete Installation Guide

**For Users Who Want to Use This KiCAD MCP Server**

---

## 📋 Prerequisites

Before starting, make sure you have:

- ✅ **Windows 10/11** (or Linux/macOS)
- ✅ **KiCAD 9.0** installed
- ✅ **Node.js 18+** installed
- ✅ **Python 3.9+** installed
- ✅ **Claude Desktop** or **Claude Code** installed
- ✅ **Git** (to clone the repository)

---

## 🚀 Step-by-Step Installation

### **Step 1: Install Prerequisites**

#### **1.1 Install KiCAD 9.0**

**Download from:** https://www.kicad.org/download/

**Windows:**
- Download the installer
- Run `kicad-9.0-setup.exe`
- Install to default location: `C:\Program Files\KiCad\9.0`

**Verify installation:**
```cmd
"C:\Program Files\KiCad\9.0\bin\kicad.exe" --version
```

---

#### **1.2 Install Node.js**

**Download from:** https://nodejs.org/

**Windows:**
- Download Node.js 20 LTS
- Run installer
- Accept defaults

**Verify installation:**
```cmd
node --version
npm --version
```

Should show: `v20.x.x` and `10.x.x`

---

#### **1.3 Install Python**

**Windows:**
- Python is bundled with KiCAD 9.0!
- Location: `C:\Program Files\KiCad\9.0\bin\python.exe`

**Verify:**
```cmd
"C:\Program Files\KiCad\9.0\bin\python.exe" --version
```

Should show: `Python 3.11.x`

---

#### **1.4 Install Claude Desktop/Code**

**Download from:** https://claude.ai/download

Install Claude Desktop or Claude Code (your choice).

---

### **Step 2: Download the KiCAD MCP Server**

#### **Option A: Clone with Git (Recommended)**

```bash
cd C:\
git clone https://github.com/LIsha-P-BNC/kicad_mcp.git
cd kicad_mcp
```

#### **Option B: Download ZIP**

1. Go to: https://github.com/LIsha-P-BNC/kicad_mcp
2. Click **Code** → **Download ZIP**
3. Extract to `C:\kicad_mcp`

---

### **Step 3: Install Dependencies**

Open **Command Prompt** or **PowerShell**:

```bash
# Navigate to the project
cd C:\kicad_mcp

# Install Node.js dependencies
npm install

# Install Python dependencies
pip install -r requirements.txt

# Build the server
npm run build
```

**Expected output:**
```
✓ Server built successfully
✓ dist/server.js created
```

---

### **Step 4: Configure Claude to Use the MCP Server**

#### **4.1 Find Your Claude Config File**

**For Claude Code:**
```
C:\Users\<YourUsername>\.claude\config\claude_desktop_config.json
```

**For Claude Desktop:**
```
C:\Users\<YourUsername>\AppData\Roaming\Claude\claude_desktop_config.json
```

**Quick way to open (PowerShell):**
```powershell
# For Claude Code
notepad "$env:USERPROFILE\.claude\config\claude_desktop_config.json"

# For Claude Desktop
notepad "$env:APPDATA\Claude\claude_desktop_config.json"
```

---

#### **4.2 Add KiCAD MCP Configuration**

**If the file is empty or new, paste this:**

```json
{
  "mcpServers": {
    "kicad": {
      "command": "node",
      "args": [
        "C:\\kicad_mcp\\dist\\server.js"
      ],
      "env": {
        "KICAD_PATH": "C:\\Program Files\\KiCad\\9.0\\bin",
        "PYTHONPATH": "C:\\Program Files\\KiCad\\9.0\\bin\\Lib\\site-packages"
      }
    }
  }
}
```

**If you already have other MCP servers, add this inside `mcpServers`:**

```json
{
  "mcpServers": {
    "existing-server": {
      ...existing config...
    },
    "kicad": {
      "command": "node",
      "args": [
        "C:\\kicad_mcp\\dist\\server.js"
      ],
      "env": {
        "KICAD_PATH": "C:\\Program Files\\KiCad\\9.0\\bin",
        "PYTHONPATH": "C:\\Program Files\\KiCad\\9.0\\bin\\Lib\\site-packages"
      }
    }
  }
}
```

**⚠️ IMPORTANT:**
- Use `\\` (double backslash) in paths!
- If you installed to a different location, update the paths
- Save the file!

---

### **Step 5: Restart Claude**

1. **Close Claude completely**
   - Exit from system tray if needed

2. **Wait 3-5 seconds**

3. **Open Claude again**

The MCP server will start automatically!

---

### **Step 6: Test the Installation**

**In Claude, type:**

```
List KiCAD symbol libraries
```

**Expected result:**
```
Found 223 symbol libraries:
- Device
- MCU_Espressif
- Connector
- ...
```

✅ **If you see this, it's working!**

❌ **If you get an error, see Troubleshooting below**

---

## 🎯 Quick Test - Create Your First PCB

Try these prompts in Claude:

```
1. Create a new project called "TestBoard" in C:\Projects
2. Set board size to 100mm x 80mm
3. Place a resistor at (50, 40)mm
4. Show me the board
```

If this works, you're ready to design PCBs with natural language! 🎉

---

## 🔧 Troubleshooting

### **Problem 1: "kicad server not found"**

**Solution:** Check config file paths are correct

```powershell
# Verify server.js exists
dir C:\kicad_mcp\dist\server.js

# Verify KiCAD exists
dir "C:\Program Files\KiCad\9.0\bin\kicad.exe"
```

If paths are different, update the config file!

---

### **Problem 2: "Python module not found"**

**Solution:** Test Python can find KiCAD modules

```cmd
cd "C:\Program Files\KiCad\9.0\bin"
python -c "import pcbnew; print('OK')"
```

If this fails:
```cmd
pip install pcbnew
```

---

### **Problem 3: Server crashes on startup**

**Solution:** Test server manually

```cmd
cd C:\kicad_mcp
node dist\server.js
```

Look at error messages and:
- Check Node.js version (must be 18+)
- Reinstall dependencies: `npm install`
- Rebuild: `npm run build`

---

### **Problem 4: "Permission denied"**

**Solution:** Run as administrator once

Right-click Command Prompt → **Run as Administrator**

```cmd
cd C:\kicad_mcp
npm install
npm run build
```

---

### **Problem 5: Can't find Claude config file**

**Find it manually:**

1. Press `Win + R`
2. Type: `%USERPROFILE%\.claude\config`
3. If folder doesn't exist, create it
4. Create file: `claude_desktop_config.json`

---

## 📂 File Structure

After installation, you should have:

```
C:\kicad_mcp\
├── dist\
│   └── server.js          ← MCP server (this runs)
├── python\
│   └── kicad_interface.py ← KiCAD Python API
├── src\
│   └── server.ts          ← Source code
├── package.json
├── README.md
└── node_modules\          ← Installed after npm install
```

---

## 🌍 Platform-Specific Notes

### **Linux**

Config file location:
```
~/.config/Claude/claude_desktop_config.json
```

KiCAD path:
```
/usr/bin
```

Example config:
```json
{
  "mcpServers": {
    "kicad": {
      "command": "node",
      "args": ["/home/user/kicad_mcp/dist/server.js"],
      "env": {
        "KICAD_PATH": "/usr/bin"
      }
    }
  }
}
```

---

### **macOS**

Config file location:
```
~/Library/Application Support/Claude/claude_desktop_config.json
```

KiCAD path:
```
/Applications/KiCad/KiCad.app/Contents/MacOS
```

Example config:
```json
{
  "mcpServers": {
    "kicad": {
      "command": "node",
      "args": ["/Users/username/kicad_mcp/dist/server.js"],
      "env": {
        "KICAD_PATH": "/Applications/KiCad/KiCad.app/Contents/MacOS"
      }
    }
  }
}
```

---

## ✅ Verification Checklist

Before asking for help, verify:

- [ ] KiCAD 9.0 installed at correct path
- [ ] Node.js 18+ installed
- [ ] Python 3.9+ available
- [ ] Ran `npm install` successfully
- [ ] Ran `npm run build` successfully
- [ ] `dist/server.js` exists
- [ ] Config file has correct paths with `\\`
- [ ] Claude was fully restarted
- [ ] Test command works: "List KiCAD symbol libraries"

---

## 🎓 What You Can Do Now

Once installed, you can use natural language to:

✅ **Create PCB projects**
```
Create a new project called "MyBoard"
```

✅ **Set board size**
```
Set board to 100mm x 80mm
```

✅ **Place components**
```
Place an ESP32 at (50, 40)mm
Place a 10k resistor at (30, 30)mm
```

✅ **Route traces**
```
Route a trace from R1 to C1
```

✅ **Export for manufacturing**
```
Export Gerber files
```

✅ **Visualize**
```
Show me the board as PNG
```

**See the documentation:**
- `HOW_TO_USE.md` - Complete usage guide
- `PROMPT_CHEATSHEET.md` - Quick commands
- `EXAMPLE_SESSION.md` - Real examples

---

## 🆘 Getting Help

If you're stuck:

1. **Check Troubleshooting section above**
2. **Read `TROUBLESHOOTING.md`**
3. **Run diagnostics:**
   ```cmd
   cd C:\kicad_mcp
   .\scripts\diagnose.ps1
   ```
4. **Report issues:**
   https://github.com/LIsha-P-BNC/kicad_mcp/issues

---

## 🎉 Success!

Once you see:
```
Found 223 symbol libraries:
...
```

**You're ready to design PCBs with AI!** 🚀

---

## 📝 Quick Reference

**Essential Commands:**

| What You Want | Prompt |
|---------------|--------|
| Create project | `Create project "MyBoard" in C:\Projects` |
| Set board size | `Set board to 100x80mm` |
| Place component | `Place resistor R1 (10k) at (30, 40)mm` |
| Route trace | `Route trace from (10,20) to (30,40) on F.Cu` |
| Export Gerbers | `Export Gerber files to ./gerbers` |
| Show board | `Show me the board as PNG` |

---

## 🔗 Useful Links

- **GitHub:** https://github.com/LIsha-P-BNC/kicad_mcp
- **KiCAD:** https://www.kicad.org/
- **Claude:** https://claude.ai/
- **Node.js:** https://nodejs.org/

---

**Made with ❤️ for the PCB design community**

*Design PCBs by talking to AI. It's that simple.*
