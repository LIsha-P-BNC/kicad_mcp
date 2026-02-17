# KiCAD MCP Server Troubleshooting Guide

## Quick Diagnostics

Based on testing, your MCP server appears to be **working correctly**! Here's what was verified:

✅ **Build Status**: TypeScript compiled successfully
✅ **Python Environment**: KiCAD 9.0.7 Python detected at `C:\Program Files\KiCad\9.0\bin\python.exe`
✅ **pcbnew Module**: Successfully imported and validated
✅ **Server Startup**: MCP server starts and connects to STDIO transport
✅ **Library Loading**: 223 symbol libraries and footprint libraries loaded
✅ **Configuration**: Claude Desktop config properly set up

## Common Issues and Solutions

### 1. MCP Server Not Appearing in Claude Desktop

**Symptoms**: The kicad MCP server doesn't show up in Claude Desktop

**Solution**:
1. Restart Claude Desktop completely (File → Quit, not just close window)
2. Check the configuration file location: `%APPDATA%\Claude\claude_desktop_config.json`
3. Verify the config matches:
```json
{
  "mcpServers": {
    "kicad": {
      "command": "node",
      "args": [
        "C:\\KiCAD-MCP-Server\\dist\\index.js"
      ],
      "env": {
        "KICAD9_FOOTPRINT_DIR": "C:\\Program Files\\KiCad\\9.0\\share\\kicad\\footprints"
      }
    }
  }
}
```

### 2. Tools Not Working / Commands Failing

**Symptoms**: MCP server appears but commands fail or timeout

**Possible Causes**:
- Project not built after code changes
- KiCAD Python path issues
- PYTHONPATH not set correctly

**Solution**:
```bash
# Rebuild the project
cd C:\KiCAD-MCP-Server
npm run build

# Test Python interface manually
"C:\Program Files\KiCad\9.0\bin\python.exe" -c "import pcbnew; print('OK')"

# If the above fails, set PYTHONPATH:
$env:PYTHONPATH="C:\Program Files\KiCad\9.0\lib\python3\dist-packages"
```

### 3. "Python process is not running" Error

**Symptoms**: Commands fail with "Python process for KiCAD scripting is not running"

**Solution**:
1. Check Python executable exists:
```bash
Test-Path "C:\Program Files\KiCad\9.0\bin\python.exe"
```

2. If not found, update your Claude Desktop config to use system Python:
```json
"env": {
  "KICAD_PYTHON": "C:\\Users\\Admin\\AppData\\Local\\Programs\\Python\\Python311\\python.exe",
  "PYTHONPATH": "C:\\Program Files\\KiCad\\9.0\\lib\\python3\\dist-packages"
}
```

### 4. Command Timeouts

**Symptoms**: Commands timeout after 30 seconds

**Causes**:
- Large board files
- Complex DRC checks
- Slow file I/O

**Solution**: Most commands have automatic timeout extensions. For DRC and exports, timeout is 10 minutes. No action needed.

### 5. "Module 'pcbnew' not found"

**Symptoms**: Python can't import pcbnew module

**Solution**:
1. Verify KiCAD installation:
```bash
Test-Path "C:\Program Files\KiCad\9.0\bin\Lib\site-packages\pcbnew.py"
```

2. If missing, reinstall KiCAD 9.0 from https://www.kicad.org/download/windows/

3. Add to Claude Desktop config:
```json
"env": {
  "PYTHONPATH": "C:\\Program Files\\KiCad\\9.0\\lib\\python3\\dist-packages;C:\\Program Files\\KiCad\\9.0\\bin\\Lib\\site-packages"
}
```

### 6. File Access / Permission Errors

**Symptoms**: "Permission denied" or "File not found" errors

**Solution**:
1. Check file paths use absolute paths, not relative
2. Ensure KiCAD UI is closed when modifying files
3. For schematic operations, reload in KiCAD after changes

### 7. JLCPCB Features Not Working

**Symptoms**: JLCPCB search/parts commands fail

**Note**: JLCPCB API features require API credentials (optional). The local database works without credentials.

**Solution**:
```bash
# Download JLCPCB parts database (one-time, ~5-10 minutes)
# Use the mcp__kicad__download_jlcpcb_database tool through Claude
```

Set API credentials in environment (optional):
```json
"env": {
  "JLCPCB_API_KEY": "your-api-key",
  "JLCPCB_API_SECRET": "your-api-secret"
}
```

## Testing Commands

### Test MCP Server Startup
```bash
cd C:\KiCAD-MCP-Server
node dist/index.js
# Should see "KiCAD MCP SERVER READY"
# Press Ctrl+C to stop
```

### Test Python Interface
```bash
cd C:\KiCAD-MCP-Server
echo '{"command": "ping", "params": {}}' | "C:\Program Files\KiCad\9.0\bin\python.exe" python/kicad_interface.py
# Should return: {"success": true, "result": "pong", "backend": "SWIG"}
```

### Test pcbnew Import
```bash
"C:\Program Files\KiCad\9.0\bin\python.exe" -c "import pcbnew; print(pcbnew.Version())"
# Should print: 9.0.7 (or your KiCAD version)
```

## Viewing Logs

### Python Interface Logs
```
C:\Users\Admin\.kicad-mcp\logs\kicad_interface.log
```

### TypeScript Server Logs
Logs appear in Claude Desktop's developer console:
1. View → Developer → Toggle Developer Tools
2. Check the Console tab for errors

## Environment Variables Reference

| Variable | Purpose | Example |
|----------|---------|---------|
| `KICAD_PYTHON` | Override Python executable | `C:\Program Files\KiCad\9.0\bin\python.exe` |
| `PYTHONPATH` | Python module search path | `C:\Program Files\KiCad\9.0\lib\python3\dist-packages` |
| `KICAD9_FOOTPRINT_DIR` | Footprint library location | `C:\Program Files\KiCad\9.0\share\kicad\footprints` |
| `JLCPCB_API_KEY` | JLCPCB API key (optional) | Your API key |
| `JLCPCB_API_SECRET` | JLCPCB API secret (optional) | Your API secret |

## Getting More Help

1. **Check the logs** - Most issues are logged with detailed error messages
2. **Enable debug logging** - Edit `src/server.ts` and set logLevel to `'debug'`
3. **Test components individually** - Use the testing commands above to isolate issues
4. **GitHub Issues** - Report bugs at https://github.com/[your-repo]/issues

## Known Limitations

1. **SWIG Backend**: Currently uses file-based SWIG backend. Changes require reloading files in KiCAD UI.
2. **IPC Backend**: Optional real-time backend requires `kicad-python` package (not installed by default).
3. **Large Boards**: DRC and export operations may take several minutes for complex designs.
4. **Windows Only**: Full testing done on Windows. Linux/Mac support is experimental.

## Your Current Setup

Based on diagnostics:
- **Platform**: Windows 11 Pro 10.0.26100
- **KiCAD Version**: 9.0.7
- **Python**: 3.11.5 (KiCAD bundled)
- **MCP SDK**: 1.21.0
- **Backend**: SWIG (file-based)
- **Libraries**: 223 symbol libraries loaded
- **Status**: ✅ All systems operational

If you're still experiencing issues, please provide:
1. The specific error message
2. What command/tool you were trying to use
3. Contents of `C:\Users\Admin\.kicad-mcp\logs\kicad_interface.log` (last 50 lines)
