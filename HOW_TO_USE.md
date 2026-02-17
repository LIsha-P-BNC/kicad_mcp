# How to Use KiCAD MCP Server - Complete Guide

## Table of Contents
1. [Getting Started](#getting-started)
2. [Basic Workflow](#basic-workflow)
3. [Example Prompts](#example-prompts)
4. [Complete Project Examples](#complete-project-examples)
5. [Advanced Features](#advanced-features)

---

## Getting Started

### Prerequisites
- KiCAD installed on your system
- MCP server running (configured in your Claude Code or MCP client)
- Basic understanding of PCB design concepts

### Starting a New Project

**Simple Prompt:**
```
Create a new KiCAD project called "MyCircuit" in C:\Projects
```

**What happens:**
- Creates project files (.kicad_pro, .kicad_pcb, .kicad_sch)
- Sets up default board and schematic
- Ready for component placement

---

## Basic Workflow

### 1. Project Creation

**Prompt Examples:**
```
Create a new PCB project called "LEDController"
Set up a 100mm x 80mm board
```

### 2. Component Placement

**Prompt Examples:**
```
Search for ESP32 components
Place an ESP32-C3 microcontroller at position (50, 40) mm
Add a 0805 10k resistor at (30, 25) mm
Place an LED at (60, 30) mm
```

### 3. Schematic Design

**Prompt Examples:**
```
Create a schematic for my project
Add a resistor R1 with value 330Ω to the schematic
Connect ESP32 GPIO2 to the resistor R1 pin 1
Connect resistor R1 pin 2 to LED anode
Connect LED cathode to ground
```

### 4. Board Layout

**Prompt Examples:**
```
Add a board outline as rectangle 100x80mm
Add mounting holes at corners (5mm from edges, 3mm diameter)
Set the board to 4 layers
Add copper pour for ground on bottom layer
```

### 5. Routing

**Prompt Examples:**
```
Route a trace from R1 to LED on F.Cu layer, 0.3mm width
Add a via at position (55, 35) mm
Connect net GND with copper pour on B.Cu layer
```

### 6. Design Validation

**Prompt Examples:**
```
Run design rule check (DRC)
Show me DRC violations
Check clearance between R1 and C1
Get board design rules
```

### 7. Export for Manufacturing

**Prompt Examples:**
```
Export Gerber files to ./output folder
Generate BOM in CSV format
Export board as PDF
Create position file for assembly
Export 3D model as STEP file
```

---

## Example Prompts

### Searching & Browsing

```
What symbol libraries are available?
Search for STM32 microcontrollers
Find 0603 capacitor footprints
List all ESP32 modules
Search for USB-C connectors
```

### Component Operations

```
Place component R1 (resistor 10k, 0805) at (25, 30) mm
Move component R1 to (35, 40) mm
Rotate component U1 by 90 degrees
Delete component C5
Find component with reference "U2"
Group components R1, R2, R3 into "pullup-resistors"
```

### Layer Management

```
Add a new signal layer called "Power"
Set active layer to F.Cu (front copper)
Get list of all layers
Add text "Version 1.0" on F.Silkscreen layer at (10, 10) mm
```

### Net and Routing

```
Create a new net called "VCC"
Assign net "VCC" to net class "Power"
Route trace from (10, 20) to (30, 40) on F.Cu, width 0.5mm
Add via at (25, 25) connected to GND
Add copper pour for GND on B.Cu layer
```

### Design Rules

```
Set minimum track width to 0.15mm
Set default via diameter to 0.6mm, drill 0.3mm
Set clearance to 0.2mm
Create net class "Power" with 0.5mm traces
Add design rule for high-speed signals
```

---

## Complete Project Examples

### Example 1: Simple LED Blinker

**Step-by-step prompts:**

```
1. "Create a new project called LEDBlinker in C:\Projects"

2. "Set board size to 50mm x 50mm"

3. "Create a schematic for the project"

4. "Add these components to the schematic:
   - ESP32-C3 microcontroller as U1
   - 330Ω resistor as R1
   - LED as D1
   - 10µF capacitor as C1"

5. "Connect the schematic:
   - Connect ESP32 GPIO2 to R1 pin 1
   - Connect R1 pin 2 to D1 anode
   - Connect D1 cathode to GND net
   - Connect C1 between VCC and GND"

6. "Place components on the board:
   - ESP32 at center (25, 25) mm
   - R1 at (35, 25) mm
   - D1 at (40, 25) mm
   - C1 near ESP32 at (25, 20) mm"

7. "Route the connections:
   - Route trace from ESP32 GPIO2 to R1, width 0.3mm on F.Cu
   - Route from R1 to D1, width 0.3mm
   - Add ground pour on B.Cu layer"

8. "Run DRC to check for errors"

9. "Export Gerber files to ./gerbers folder"
```

### Example 2: Power Supply Module

```
1. "Create new project PowerSupply"

2. "Set up 80mm x 60mm 2-layer board"

3. "Search for LM7805 voltage regulator"

4. "Add schematic components:
   - LM7805 voltage regulator U1
   - 100µF input capacitor C1
   - 10µF output capacitor C2
   - Input connector J1
   - Output connector J2"

5. "Create schematic connections:
   - J1 pin 1 (VIN) to U1 input pin
   - J1 pin 2 (GND) to U1 GND pin
   - U1 output to J2 pin 1 (VOUT)
   - U1 GND to J2 pin 2 (GND)
   - Add C1 between VIN and GND
   - Add C2 between VOUT and GND"

6. "Set design rules:
   - Power traces: 0.8mm width
   - Signal traces: 0.3mm width
   - Clearance: 0.3mm"

7. "Create net class 'Power' with 0.8mm traces for VIN, VOUT, GND"

8. "Add mounting holes at (5,5), (75,5), (5,55), (75,55) - 3mm diameter"

9. "Run DRC and fix violations"

10. "Export BOM in CSV format and Gerber files"
```

### Example 3: Sensor Module with JLCPCB Parts

```
1. "Create project SensorModule"

2. "Download JLCPCB parts database"
   (Note: Requires JLCPCB_API_KEY environment variable)

3. "Search JLCPCB parts for BME280 sensor, in stock, basic parts only"

4. "Search JLCPCB parts for 0805 100nF capacitor, basic parts"

5. "Get details for LCSC part C2286 (ESP32-C3)"

6. "Add components from JLCPCB library to schematic"

7. "Place components optimally for assembly"

8. "Generate position file for SMT assembly"

9. "Export BOM with LCSC part numbers"
```

---

## Advanced Features

### 1. Library Search

**Find specific components:**
```
Search symbol libraries for "LM358"
Get information about Device:R symbol
List all footprints in Resistor_SMD library
Search footprints for "QFN-32"
```

### 2. JLCPCB Integration

**Cost-optimized design:**
```
Search JLCPCB parts for "STM32F103C8T6" with Basic library type
Find cheaper alternatives for LCSC part C25804
Get stock and pricing for component C2286
Suggest JLCPCB alternatives for current BOM
```

### 3. Design Rule Management

**Advanced DRC:**
```
Set layer-specific constraints for F.Cu: min track 0.15mm
Create differential pair net class with 0.2mm width, 0.15mm gap
Check specific clearance between components U1 and U2
Get all current DRC violations filtered by severity
```

### 4. Visualization

**View your design:**
```
Show me 2D view of the board as PNG
Generate board image 1920x1080 resolution
Export board with only F.Cu and F.Silkscreen layers visible
```

### 5. Batch Operations

**Multiple operations:**
```
Place 10 decoupling capacitors in a grid pattern
Add test points for all power nets
Group all power components together
Replace all 0603 resistors with 0805 footprints
```

---

## Tips for Effective Prompts

### ✅ DO:
- Be specific with component values and positions
- Use standard units (mm, inch)
- Specify layers for routing (F.Cu, B.Cu, etc.)
- Include net names for connections
- Request DRC before exporting

### ❌ DON'T:
- Use vague positioning ("put it somewhere")
- Forget to specify component footprints
- Skip design rule checks
- Export without verifying connections

---

## Common Workflows

### Quick Prototyping
```
1. Create project
2. Add components to schematic
3. Generate netlist
4. Auto-place components
5. Quick route
6. Export Gerbers
```

### Production-Ready Design
```
1. Create project with design rules
2. Use JLCPCB parts for cost optimization
3. Careful schematic design with net classes
4. Manual component placement
5. Layer-aware routing with proper widths
6. Multiple DRC passes
7. Add test points and fiducials
8. Generate full documentation (BOM, assembly drawings, Gerbers)
```

### Design Review
```
1. Open existing project
2. Run DRC
3. Check all net connections
4. Verify component footprints
5. Review design rules compliance
6. Export review PDF
```

---

## Troubleshooting

**Common Issues:**

1. **"Footprint not found"**
   - Search available footprints first
   - Use full library:footprint format

2. **"Board not loaded"**
   - Create or open a project first
   - Check project path

3. **DRC violations**
   - Check design rules
   - Review net clearances
   - Verify track widths

4. **Export failures**
   - Ensure output directory exists
   - Check file permissions
   - Run DRC first

---

## Next Steps

- **Explore JLCPCB integration** for cost-effective manufacturing
- **Try example projects** to learn the workflow
- **Experiment with layer stackups** for complex designs
- **Use design rule presets** for different manufacturers

---

## Reference Links

- KiCAD Documentation: https://docs.kicad.org/
- JLCPCB Capabilities: https://jlcpcb.com/capabilities/pcb-capabilities
- PCB Design Guidelines: https://www.pcbway.com/blog/help_center/PCB_Design_Tutorial.html

---

*For more examples and detailed tool documentation, see the `/docs` folder.*
