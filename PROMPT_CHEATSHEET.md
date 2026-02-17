# KiCAD MCP Prompt Cheat Sheet

Quick reference for common prompts to design PCBs with KiCAD MCP.

---

## 🚀 Quick Start (5 Minutes)

```
1. Create a new project called "MyBoard"
2. Set board size to 100mm x 80mm
3. Search for ESP32-C3 component
4. Place ESP32-C3 at position (50, 40) mm
5. Add a 10k resistor at (60, 40) mm
6. Run DRC
7. Show me the board as PNG
```

---

## 📋 Essential Prompts by Category

### Project Management
```
Create new project "ProjectName" in C:\Path
Open project at C:\Path\project.kicad_pcb
Save current project
Get project information
```

### Board Setup
```
Set board size to [width]mm x [height]mm
Add board outline as rectangle [W]x[H]mm
Add mounting hole at ([x], [y])mm, diameter [d]mm
Set board to [N] layers
Get board information
```

### Component Search
```
Search for [component_name]
List symbol libraries
Search symbols for "[query]"
Get symbol info for Device:R
Search footprints for "0805"
List footprints in Resistor_SMD library
```

### Component Placement
```
Place [component] at ([x], [y])mm
Place resistor R1 (10k, 0805) at (30, 40)mm
Move component [ref] to ([x], [y])mm
Rotate component [ref] by [angle] degrees
Delete component [ref]
```

### Schematic Design
```
Create schematic for my project
Add component [symbol] to schematic at ([x], [y])
Add schematic component Device:R as R1 with value 10k
Connect [component1] pin [pin1] to [component2] pin [pin2]
Add net label "[net_name]" at position ([x], [y])
Connect component [ref] pin [pin] to net [net_name]
Generate netlist
```

### Routing & Connections
```
Route trace from ([x1], [y1]) to ([x2], [y2]) on F.Cu, width [w]mm
Add via at ([x], [y])mm connected to [net]
Add copper pour for [net] on B.Cu layer
Create new net called "[net_name]"
Assign net "[net]" to net class "[class]"
Get net connections for "[net_name]"
```

### Layers
```
Add new layer called "[name]"
Set active layer to F.Cu
Get list of layers
Add text "[text]" on F.Silkscreen at ([x], [y])mm
```

### Design Rules
```
Get current design rules
Set minimum track width to [w]mm
Set clearance to [c]mm
Set via diameter to [d]mm, drill [drill]mm
Create net class "[name]" with [w]mm track width
Set design rules for power traces
```

### Validation
```
Run DRC
Get DRC violations
Check clearance between [item1] and [item2]
Show DRC errors only
```

### Export & Manufacturing
```
Export Gerber files to ./[folder]
Export BOM as CSV to ./[file]
Export board as PDF
Export 3D model as STEP
Generate position file for assembly
Export netlist
Show me 2D view of board as PNG
```

### JLCPCB Integration
```
Download JLCPCB parts database
Search JLCPCB parts for "[component]"
Search JLCPCB parts: category="Resistors", package="0805", in_stock=true
Get JLCPCB part details for C[number]
Suggest alternatives for LCSC part C[number]
Get JLCPCB database statistics
```

---

## 🎯 Complete Workflow Templates

### Simple LED Circuit
```
Create project "LED_Blinker"
Set board 50x50mm
Add ESP32, resistor 330Ω, LED to schematic
Connect: ESP32 GPIO2 -> R1 -> LED -> GND
Place components
Route connections
Run DRC
Export Gerbers
```

### Power Supply
```
Create project "PowerSupply"
Set board 80x60mm, 2 layers
Search for LM7805
Add regulator, capacitors, connectors
Create power net class (0.8mm traces)
Add mounting holes at corners
Route power traces
Run DRC
Export BOM and Gerbers
```

### Using JLCPCB Parts
```
Download JLCPCB database
Search JLCPCB: "STM32F103", library_type="Basic"
Get part details C[number]
Place components from JLCPCB
Generate position file
Export BOM with LCSC numbers
```

---

## 💡 Pro Tips

### Positioning
- Always use units: `mm` or `inch`
- Center of 100x80mm board: `(50, 40)`
- Grid placement: `(10, 10)`, `(20, 10)`, `(30, 10)`...

### Layers
- Front copper: `F.Cu`
- Back copper: `B.Cu`
- Front silkscreen: `F.Silkscreen`
- Board edge: `Edge.Cuts`

### Component References
- Resistors: `R1`, `R2`, `R3`...
- Capacitors: `C1`, `C2`, `C3`...
- ICs: `U1`, `U2`, `U3`...
- Diodes: `D1`, `D2`, `D3`...
- Connectors: `J1`, `J2`, `J3`...

### Standard Footprints
- SMD resistors: `Resistor_SMD:R_0603_1608Metric`, `R_0805_2012Metric`
- SMD capacitors: `Capacitor_SMD:C_0603_1608Metric`, `C_0805_2012Metric`
- Through-hole: `Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P10.16mm_Horizontal`

### Common Sizes
- 0603: 1.6mm x 0.8mm
- 0805: 2.0mm x 1.2mm
- 1206: 3.2mm x 1.6mm

### Trace Widths (General)
- Power: 0.5-1.0mm
- Signal: 0.2-0.4mm
- High-current: 1.0mm+
- Fine-pitch IC: 0.15-0.2mm

### Standard Clearances
- Basic: 0.15-0.2mm
- Power: 0.3mm+
- High-voltage: 0.5mm+

---

## 🔍 Debugging Prompts

```
Why did DRC fail?
Show me all components on the board
Get properties of component R1
Find all connections to net VCC
What footprint is used for U1?
List all nets in the design
Check if component R5 exists
```

---

## 📦 Common Component Searches

### Microcontrollers
```
Search for "ESP32-C3"
Search for "STM32F103"
Search for "ATmega328"
Search for "RP2040"
```

### Passives
```
Search footprints "0805"
Search symbols "Device:R"
Search symbols "Device:C"
Search symbols "Device:LED"
```

### Connectors
```
Search for "USB-C"
Search for "pin header"
Search for "JST connector"
```

### Power Components
```
Search for "LM7805"
Search for "AMS1117"
Search for "voltage regulator"
```

---

## ⚡ Speed Commands

One-liner prompts for common tasks:

```
Create "Test" project, 100x80mm board, add mounting holes
Place ESP32 at (50,40), add decoupling cap nearby
Route all power nets with 0.8mm traces
Run DRC and export Gerbers to ./output
Show board preview and export as PDF
```

---

## 🎨 Example: Complete Design in Chat

```markdown
User: Create a simple Arduino-compatible board

Assistant will:
1. Create project
2. Add ATmega328, USB connector, crystal, voltage regulator
3. Set up schematic connections
4. Place components
5. Route traces
6. Run DRC
7. Export manufacturing files
```

---

## 📚 More Examples

See `HOW_TO_USE.md` for:
- Detailed workflow examples
- Step-by-step tutorials
- Advanced features
- Troubleshooting guide

---

**Remember:** Be specific! Include:
- Component values (10k, 100nF)
- Positions with units (30mm, 1.5inch)
- Layer names (F.Cu, B.Cu)
- Net names (VCC, GND, SIGNAL1)

Happy designing! 🎉
