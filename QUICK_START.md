# KiCAD MCP Server - Quick Start Guide

## ✅ Your Server is Ready!

Good news: Your KiCAD MCP server is **working correctly**!

## Quick Test

Run this diagnostic to confirm everything is working:

```powershell
cd C:\KiCAD-MCP-Server
powershell -ExecutionPolicy Bypass -File scripts/diagnose.ps1
```

Expected result: **All checks should pass** ✅

## Using the MCP Server

### Step 1: Restart Claude Desktop
1. **Quit Claude Desktop** completely (File → Quit, not just close)
2. **Restart Claude Desktop**

### Step 2: Verify Tools are Available
The KiCAD MCP server provides these tool categories:
- Project management (create, open, save projects)
- Board design (set size, add outlines, mounting holes)
- Component placement (add, move, rotate, delete components)
- Routing (traces, vias, copper pours)
- Design rules (DRC, clearances, net classes)
- Export (Gerber, PDF, SVG, 3D models, BOM)
- Schematic tools (components, wiring, netlists)
- Library management (footprints, symbols, JLCPCB integration)

### Step 3: Try Your First Command

Start with simple commands:

#### List Available Libraries
```
Show me available KiCAD footprint libraries
```

#### Search for Components
```
Search for resistor symbols in KiCAD
```

#### Create a New Project
```
Create a new KiCAD project called MyFirstBoard
```

## Example Workflow

Here's a complete example of creating a simple circuit:

### 1. Create Project
```
Create a new KiCAD project in C:\Projects called LEDCircuit
```

### 2. Set Up Board
```
Create a board 50mm x 30mm
Add a rectangular board outline
```

### 3. Place Components
```
Place a resistor (0603) at 25mm, 15mm as R1
Place an LED (0603) at 30mm, 15mm as D1
```

### 4. Route Connections
```
Connect R1 to D1
Add a via at 27mm, 15mm
```

### 5. Export
```
Export Gerber files for manufacturing
Generate a PDF of the board design
```

## Configuration

Your current configuration (`%APPDATA%\Claude\claude_desktop_config.json`):

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

This is correct and working! ✅

## Environment Details

- **KiCAD Version**: 9.0.7
- **Python**: 3.11.5 (KiCAD bundled)
- **Backend**: SWIG (file-based)
- **MCP SDK**: 1.21.0
- **Platform**: Windows 11 Pro

## Available Tools

The server provides 100+ tools organized in these categories:

### Core Tools
- `list_tool_categories` - List all available tool categories
- `get_category_tools` - Get tools in a specific category
- `execute_tool` - Execute a KiCAD tool
- `search_tools` - Search for tools by keyword

### Project Tools
- `create_project` - Create new KiCAD project
- `open_project` - Open existing project
- `save_project` - Save current project
- `get_project_info` - Get project information

### Board Tools
- `set_board_size` - Set PCB dimensions
- `add_board_outline` - Add board outline (rectangle, circle, polygon)
- `add_mounting_hole` - Add mounting holes
- `add_board_text` - Add text to board layers
- `get_board_info` - Get board information
- `get_board_2d_view` - Generate board visualization

### Component Tools
- `place_component` - Place component on board
- `move_component` - Move component
- `rotate_component` - Rotate component
- `delete_component` - Remove component
- `find_component` - Search for components
- `get_component_properties` - Get component details

### Routing Tools
- `add_net` - Create electrical net
- `route_trace` - Route copper trace
- `add_via` - Add via
- `add_copper_pour` - Add ground/power plane

### Library Tools
- `list_libraries` - List footprint libraries
- `search_footprints` - Search for footprints
- `get_footprint_info` - Get footprint details
- `list_symbol_libraries` - List symbol libraries
- `search_symbols` - Search for symbols
- `get_symbol_info` - Get symbol details

### JLCPCB Integration
- `search_jlcpcb_parts` - Search JLCPCB parts catalog
- `get_jlcpcb_part` - Get part details
- `download_jlcpcb_database` - Download parts database
- `suggest_jlcpcb_alternatives` - Find alternative parts

### Export Tools
- `export_gerber` - Export Gerber files
- `export_pdf` - Export PDF
- `export_svg` - Export SVG
- `export_3d` - Export 3D model (STEP, STL, VRML)
- `export_bom` - Export bill of materials
- `export_position_file` - Export component positions

## Troubleshooting

### Server Not Appearing in Claude Desktop
**Solution**: Restart Claude Desktop completely (File → Quit)

### Commands Failing
**Check**:
1. Logs at `C:\Users\Admin\.kicad-mcp\logs\kicad_interface.log`
2. Run diagnostic: `powershell scripts/diagnose.ps1`

### Want More Details?
See these files:
- `TROUBLESHOOTING.md` - Detailed troubleshooting guide
- `DIAGNOSTIC_RESULTS.md` - Your system diagnostic results

## Common Questions

### Q: Do I need KiCAD UI running?
**A**: No! The MCP server communicates with KiCAD's Python API directly. You can close the KiCAD UI.

### Q: Can I see changes in real-time?
**A**: Currently using SWIG backend (file-based). Reload files in KiCAD UI to see changes. Optional IPC backend available for real-time updates.

### Q: Where are project files saved?
**A**: Files are saved wherever you specify in commands. Use absolute paths like `C:\Projects\MyBoard.kicad_pcb`

### Q: Can I use JLCPCB features?
**A**: Yes! Local database works without API keys. Download database first with `download_jlcpcb_database` command.

## Need Help?

1. **Diagnostic**: Run `scripts/diagnose.ps1`
2. **Logs**: Check `C:\Users\Admin\.kicad-mcp\logs\kicad_interface.log`
3. **Documentation**: Read `TROUBLESHOOTING.md`
4. **Specific Issue**: Describe what you're trying to do and what's happening

## What to Report if Something's Wrong

Please provide:
1. Specific command you tried
2. Error message received
3. Relevant log entries (last 20-50 lines)
4. What you expected to happen

---

**Ready to Start?** Try: "Show me KiCAD footprint libraries" or "Create a new project called Test"
