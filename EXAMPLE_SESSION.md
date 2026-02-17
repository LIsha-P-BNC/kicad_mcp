# Example Design Session: LED Blinker with ESP32

This is a real example of how to design a complete PCB using natural language prompts.

---

## Project Goal
Design a simple LED blinker circuit with:
- ESP32-C3 microcontroller
- LED with current-limiting resistor
- Power connector
- Decoupling capacitor

---

## Session Transcript

### Step 1: Project Setup

**User:** Create a new KiCAD project called "LEDBlinker" in C:\Projects

**System Response:**
```json
{
  "success": true,
  "project": {
    "name": "LEDBlinker",
    "path": "C:\\Projects\\LEDBlinker.kicad_pro"
  }
}
```

---

### Step 2: Board Configuration

**User:** Set up a 60mm x 40mm board with mounting holes at the corners

**You would use:**
```
Set board size to 60mm x 40mm
Add mounting hole at (5, 5)mm, diameter 3mm
Add mounting hole at (55, 5)mm, diameter 3mm
Add mounting hole at (5, 35)mm, diameter 3mm
Add mounting hole at (55, 35)mm, diameter 3mm
```

---

### Step 3: Component Selection

**User:** What ESP32 modules are available?

**Response:** Lists available ESP32 modules from symbol library

**User:** Search for 0805 resistor footprint

**Response:** Shows available 0805 footprints

---

### Step 4: Component Placement

**User:** Place the following components:
- ESP32-C3 at center (30, 20)mm
- 330Ω resistor (R1) at (45, 20)mm
- LED (D1) at (52, 20)mm
- 10µF capacitor (C1) at (25, 15)mm
- 2-pin connector (J1) at (10, 20)mm

**Commands:**
```
Place ESP32-C3 microcontroller U1 at (30, 20)mm
Place resistor R1 (330Ω, 0805) at (45, 20)mm
Place LED D1 at (52, 20)mm
Place capacitor C1 (10µF, 0805) at (25, 15)mm
Place connector J1 (2-pin) at (10, 20)mm
```

---

### Step 5: Schematic Wiring

**User:** Create the circuit connections:
- J1 pin 1 to VCC net
- J1 pin 2 to GND net
- ESP32 VCC pin to VCC net
- ESP32 GND pin to GND net
- C1 between VCC and GND (decoupling)
- ESP32 GPIO2 to R1 pin 1
- R1 pin 2 to D1 anode
- D1 cathode to GND

**Commands:**
```
Create schematic
Connect J1 pin 1 to net VCC
Connect J1 pin 2 to net GND
Connect U1 VCC to net VCC
Connect U1 GND to net GND
Connect C1 pin 1 to net VCC
Connect C1 pin 2 to net GND
Connect U1 GPIO2 to R1 pin 1
Connect R1 pin 2 to D1 anode
Connect D1 cathode to net GND
```

---

### Step 6: Routing

**User:** Route the power and signal traces

**Commands:**
```
Create net class "Power" with 0.5mm track width
Assign nets VCC and GND to Power net class

Route trace from J1 to U1 VCC on F.Cu, width 0.5mm
Route trace from J1 GND to U1 GND on F.Cu, width 0.5mm
Route trace from U1 GPIO2 to R1 on F.Cu, width 0.3mm
Route trace from R1 to D1 on F.Cu, width 0.3mm
Route trace from D1 cathode to GND on F.Cu, width 0.3mm

Add ground copper pour on B.Cu layer
```

---

### Step 7: Design Validation

**User:** Run design rule check

**Command:**
```
Run DRC
```

**Response:** Shows 0 violations (or lists issues to fix)

---

### Step 8: Add Silkscreen

**User:** Add labels and version info

**Commands:**
```
Add text "LED Blinker v1.0" on F.Silkscreen at (30, 5)mm, size 1.5mm
Add text "VCC" on F.Silkscreen at (8, 18)mm
Add text "GND" on F.Silkscreen at (8, 22)mm
```

---

### Step 9: Visualization

**User:** Show me what the board looks like

**Command:**
```
Get board 2D view as PNG, 1920x1080 resolution
```

**Response:** Returns PNG image of the board design

---

### Step 10: Export for Manufacturing

**User:** Export everything I need to manufacture this board

**Commands:**
```
Export Gerber files to ./gerbers
Export BOM as CSV to ./LEDBlinker_BOM.csv
Export position file to ./LEDBlinker_positions.csv
Export PDF to ./LEDBlinker_schematic.pdf
```

---

## Alternative: Single Complex Prompt

**User:** Design a complete LED blinker circuit with ESP32-C3, 330Ω resistor, LED, decoupling cap, and power connector on a 60x40mm board, then export Gerbers

**What happens:** The MCP server would:
1. Create the project
2. Set board size
3. Add all components
4. Create connections
5. Route traces
6. Run DRC
7. Export files

---

## Tips for Natural Interaction

### ✅ Good Prompts:
- "Add a 100nF decoupling capacitor near the ESP32"
- "Route all power traces with 0.8mm width"
- "Check if there are any DRC violations"
- "Show me the board from the top view"

### ❌ Avoid:
- "Do something with the capacitor" (too vague)
- "Put stuff on the board" (not specific)
- "Make it work" (unclear what to do)

---

## Real-World Workflow

Typical conversation flow:

```
User: I want to design a sensor board with BME280 and ESP32