# KiCAD MCP Server 🎨

A Model Context Protocol (MCP) server that enables AI assistants to design PCBs using KiCAD through natural language commands.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

---

## 🚀 What is This?

This MCP server bridges AI assistants (like Claude) with KiCAD, allowing you to design complete PCBs using conversational prompts instead of clicking through menus.

### Example Interaction:

**You say:**
```
Create a new board with ESP32, add an LED with resistor, route the traces, and export Gerbers
```

**The system:**
- Creates KiCAD project
- Places components
- Routes connections
- Runs design rule checks
- Exports manufacturing files

**All through natural language!** 🎉

---

## ✨ Features

### Core Capabilities
- 🎯 **Project Management** - Create, open, save KiCAD projects
- 📦 **Component Placement** - Search and place components with natural language
- 🔌 **Schematic Design** - Create schematics and connections
- 🛤️ **PCB Routing** - Route traces, add vias, create copper pours
- ✅ **Design Validation** - Run DRC, check clearances
- 📤 **Export** - Generate Gerbers, BOM, pick-and-place, 3D models
- 🔍 **Library Access** - Search 223 symbol libraries, 155 footprint libraries
- 💰 **JLCPCB Integration** - Search parts database, get pricing/stock info

### Advanced Features
- 59 specialized tools organized in 7 categories
- Real-time board visualization
- Net class management
- Layer stackup configuration
- Design rule customization
- Batch component operations

---

## 📋 Prerequisites

- **KiCAD 8.0+** installed
- **Node.js 18+**
- **Python 3.9+**
- **MCP-compatible client** (Claude Desktop, Claude Code, etc.)

---

## 🔧 Installation

### 1. Clone Repository
```bash
git clone https://github.com/LIsha-P-BNC/kicad_mcp.git
cd kicad_mcp
```

### 2. Install Dependencies
```bash
npm install
pip install -r requirements.txt
```

### 3. Build the Server
```bash
npm run build
```

### 4. Configure MCP Client

Add to your MCP client config (e.g., Claude Desktop):

**Windows:**
```json
{
  "mcpServers": {
    "kicad": {
      "command": "node",
      "args": ["C:\\path\\to\\kicad_mcp\\dist\\server.js"],
      "env": {
        "KICAD_PATH": "C:\\Program Files\\KiCad\\8.0\\bin"
      }
    }
  }
}
```

**Linux/macOS:**
```json
{
  "mcpServers": {
    "kicad": {
      "command": "node",
      "args": ["/path/to/kicad_mcp/dist/server.js"],
      "env": {
        "KICAD_PATH": "/usr/bin"
      }
    }
  }
}
```

---

## 🎓 Quick Start

### Your First PCB in 2 Minutes

```
1. "Create a new project called HelloPCB"
2. "Set board size to 50mm x 50mm"
3. "Place an ESP32-C3 at the center"
4. "Add an LED with 330Ω resistor"
5. "Connect GPIO2 to the LED through the resistor"
6. "Run DRC"
7. "Export Gerber files"
```

**Done!** You just designed a PCB with natural language. 🎊

---

## 📚 Documentation

- **[How to Use Guide](./HOW_TO_USE.md)** - Complete guide with examples
- **[Prompt Cheat Sheet](./PROMPT_CHEATSHEET.md)** - Quick reference for common prompts
- **[Example Session](./EXAMPLE_SESSION.md)** - Real design session walkthrough
- **[Quick Start](./QUICK_START.md)** - Get up and running fast
- **[Troubleshooting](./TROUBLESHOOTING.md)** - Common issues and solutions

---

## 🎯 Use Cases

### Rapid Prototyping
Design simple circuits in minutes instead of hours:
```
Design a voltage divider with 10k and 5k resistors on a 30x20mm board
```

### Production PCBs
Create manufacturing-ready boards with JLCPCB integration:
```
Create a sensor board using only JLCPCB basic parts, export with assembly files
```

### Learning
Explore PCB design without memorizing KiCAD's interface:
```
Show me how to create a 4-layer board with impedance-controlled traces
```

### Batch Operations
Automate repetitive tasks:
```
Place 20 decoupling capacitors in a grid pattern near all ICs
```

---

## 🛠️ Available Tools (59 total)

### Categories
1. **Project** (4 tools) - Create, open, save, get info
2. **Board** (9 tools) - Layers, size, holes, zones, visualization
3. **Component** (10 tools) - Place, move, rotate, delete, search, group
4. **Schematic** (8 tools) - Components, wiring, nets, netlists
5. **Routing** (4 tools) - Traces, vias, nets, copper pours
6. **DRC** (8 tools) - Design rules, validation, clearance checks
7. **Export** (8 tools) - Gerber, BOM, PDF, 3D, position files
8. **Library** (8 tools) - Symbol/footprint search, JLCPCB integration

### Most Used Tools
```
- create_project
- place_component
- route_trace
- run_drc
- export_gerber
- search_symbols
- add_schematic_component
- get_board_2d_view
```

---

## 🌟 Example Prompts

### Simple
```
Create a 100x80mm board
Add an LED at position (50, 40)mm
Route a trace from R1 to C1
Show me the board
```

### Complex
```
Design a USB-powered ESP32 board with voltage regulator,
4 status LEDs, I2C sensor connector, and mounting holes,
optimized for JLCPCB assembly
```

### Batch Operations
```
Place ten 0.1µF capacitors near each IC for decoupling
Add test points for all power nets
Export complete manufacturing package (Gerbers, BOM, positions)
```

---

## 🔌 JLCPCB Integration

Access 100,000+ components with real pricing and stock:

```bash
# Set up API keys (optional, for database download)
export JLCPCB_API_KEY="your_key"
export JLCPCB_API_SECRET="your_secret"
```

### Usage
```
Download JLCPCB parts database
Search JLCPCB for "STM32F103" with basic parts only
Get pricing for LCSC part C2286
Find cheaper alternative to current resistor
```

**Benefits:**
- Cost optimization (Basic parts = free assembly)
- Real-time stock checking
- Automatic BOM generation with LCSC numbers

---

## 🏗️ Architecture

```
┌─────────────────┐
│   AI Assistant  │  (Claude, etc.)
└────────┬────────┘
         │ MCP Protocol
┌────────▼────────┐
│   MCP Server    │  (TypeScript/Node.js)
│   (Router)      │
└────────┬────────┘
         │ JSON-RPC
┌────────▼────────┐
│ Python Backend  │  (KiCAD API)
│  (SWIG/IPC)     │
└────────┬────────┘
         │ Python API
┌────────▼────────┐
│     KiCAD       │  (PCB Design Software)
└─────────────────┘
```

---

## 🤝 Contributing

Contributions welcome! Areas for improvement:
- Additional export formats
- More library integrations
- Auto-routing algorithms
- Design rule templates
- Component libraries

---

## 📄 License

MIT License - see [LICENSE](LICENSE) file

---

## 🙏 Acknowledgments

- KiCAD development team
- Anthropic MCP framework
- JLCPCB for parts database
- Open-source PCB design community

---

## 🐛 Known Issues

- Footprint search may return incomplete results (being fixed)
- Real-time mode requires KiCAD UI running
- JLCPCB database download requires API credentials

See [TROUBLESHOOTING.md](TROUBLESHOOTING.md) for solutions.

---

## 📞 Support

- **Issues:** https://github.com/LIsha-P-BNC/kicad_mcp/issues
- **Discussions:** https://github.com/LIsha-P-BNC/kicad_mcp/discussions
- **Documentation:** See `/docs` folder

---

## 🗺️ Roadmap

- [ ] Auto-routing integration
- [ ] More manufacturer integrations (DigiKey, Mouser)
- [ ] PCB cost estimation
- [ ] Design templates library
- [ ] Multi-board projects
- [ ] Simulation integration

---

## ⚡ Performance

- Typical operation latency: < 500ms
- Component search: < 100ms
- DRC on 100-component board: < 2s
- Gerber export: < 1s

---

**Made with ❤️ for the PCB design community**

*Design PCBs by talking to your AI assistant. It's that simple.*

---

**Quick Links:**
- [Installation](#-installation)
- [Quick Start](#-quick-start)
- [Documentation](#-documentation)
- [Examples](./EXAMPLE_SESSION.md)
- [Cheat Sheet](./PROMPT_CHEATSHEET.md)
