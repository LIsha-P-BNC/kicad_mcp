# ✅ Correct PCB Design Workflow

## 🎯 The Problem You Experienced

When you created the board, the components were **invisible** because:

1. ❌ Board outline was 0×0mm (no defined area)
2. ❌ Components placed at (100,100)mm - **outside** the view
3. ❌ Board created at (0,0) but components far away

---

## ✅ The Correct Order (Always Follow This!)

```
Step 1: Create Project
   ↓
Step 2: Set Board Size FIRST
   ↓
Step 3: Place Components INSIDE board area
   ↓
Step 4: Add traces/routing
   ↓
Step 5: Run DRC
   ↓
Step 6: Export files
```

---

## 📝 Example: Correct Workflow

### **Project: Simple LED Board**

#### **Step 1: Create Project**
```
Create a new project called "LED_Board" in C:\Projects
```

**Result:**
- ✅ Project files created
- Path: `C:\Projects\LED_Board\`

---

#### **Step 2: Set Board Size FIRST!**
```
Set board size to 100mm x 80mm
```

**Result:**
- ✅ Board outline: 100×80mm rectangle
- ✅ Edge.Cuts layer defined
- ✅ You now have a visible area!

**Why this matters:**
- Defines the **working area**
- You know where to place components (inside 0-100mm x, 0-80mm y)
- Board outline shows in KiCAD

---

#### **Step 3: Place Components INSIDE Board**

**Think about coordinates:**
- Board is 100×80mm
- Center is at (50, 40)mm
- Components should be between:
  - X: 5-95mm (leave 5mm margin)
  - Y: 5-75mm (leave 5mm margin)

**Commands:**
```
Place resistor R1 (330Ω, 0805) at (30, 40)mm
Place LED D1 (0805) at (60, 40)mm
```

**Result:**
- ✅ R1 at (30, 40) - **inside** board outline
- ✅ D1 at (60, 40) - **inside** board outline
- ✅ Both visible when you open in KiCAD!

---

#### **Step 4: Add Text/Labels**
```
Add text "LED Demo v1.0" on F.Silkscreen at (50, 10)mm
```

**Result:**
- ✅ Label visible on silkscreen layer

---

#### **Step 5: Save**
```
Save the project
```

---

#### **Step 6: View in KiCAD**

**Open KiCAD PCB Editor:**
1. File → Open Project → `LED_Board.kicad_pro`
2. Press **Ctrl + Home** (Fit in Window)
3. You see:
   - ✅ 100×80mm board outline
   - ✅ R1 resistor visible
   - ✅ D1 LED visible
   - ✅ Text label visible

---

## 🎨 Visual Comparison

### ❌ WRONG Way (What You Did)
```
Create project
   ↓
Place ESP32 at (100, 100)mm     ← Outside view!
   ↓
Place LED at (50, 40)mm
   ↓
Set board size 80×60mm          ← Too late! Components outside!
   ↓
Open in KiCAD: EMPTY SCREEN     ← Can't see components
```

### ✅ RIGHT Way
```
Create project
   ↓
Set board size 100×80mm         ← FIRST! Defines working area
   ↓
Place resistor at (30, 40)mm    ← Inside board!
   ↓
Place LED at (60, 40)mm         ← Inside board!
   ↓
Save
   ↓
Open in KiCAD: SEE EVERYTHING   ← Components visible!
```

---

## 📏 Understanding Coordinates

### Board: 100mm × 80mm

```
(0,0) ●────────────────────────● (100,0)
      │                        │
      │    Board Outline       │
      │                        │
      │   (50,40)              │
      │      ●                 │  ← Center of board
      │                        │
      │                        │
(0,80)●────────────────────────● (100,80)
```

**Safe placement zones:**
- **X: 10-90mm** (leave 10mm margins)
- **Y: 10-70mm** (leave 10mm margins)

**Examples:**
- ✅ Component at (30, 40) - **INSIDE**
- ✅ Component at (60, 40) - **INSIDE**
- ❌ Component at (110, 40) - **OUTSIDE** (won't see it!)
- ❌ Component at (100, 100) - **WAY OUTSIDE**

---

## 💡 Pro Tips

### 1. **Always Plan Board Size First**
Before placing anything, decide:
- How big should the board be?
- Set that size FIRST!

### 2. **Use Sensible Coordinates**
- Center of 100×80mm board: **(50, 40)**
- Quarter positions: **(25, 20), (75, 60)**
- Grid: Place in 10mm increments (20, 30, 40, etc.)

### 3. **Check Fit Before Saving**
```
Get board extents
```
This shows you the bounding box of all components.

### 4. **View After Every Step**
```
Show me the board as PNG
```
Verify components are where you expect!

---

## 📋 Complete Example Prompts

### Example 1: Simple LED
```
1. Create project "SimpleLED" in C:\Projects
2. Set board size to 50mm x 40mm
3. Place resistor R1 (330Ω, 0805) at (15, 20)mm
4. Place LED D1 (0805) at (35, 20)mm
5. Save project
6. Show me the board
```

### Example 2: Sensor Board
```
1. Create project "TempSensor" in C:\Electronics
2. Set board size to 80mm x 60mm
3. Add mounting holes at corners: (5,5), (75,5), (5,55), (75,55)
4. Place sensor U1 at center (40, 30)mm
5. Place capacitor C1 (0805) at (30, 30)mm
6. Add text "Temp Sensor v1" on F.Silkscreen at (40, 10)mm
7. Save and show board
```

---

## 🔧 How to Fix "Empty Board" Issue

If you already created a board and can't see components:

### Option 1: In KiCAD
1. Open the `.kicad_pcb` file
2. Press **Ctrl + Home** (Fit in Window)
3. Zoom out until you see components

### Option 2: With Prompts
```
Get board extents
Move all components to center
Save project
```

### Option 3: Start Over (Recommended)
```
Create new project with correct workflow
Set board size FIRST
Place components inside board area
```

---

## ✅ Summary: The Golden Rule

> **ALWAYS set board size BEFORE placing components!**

**Correct sequence:**
1. Create project
2. **Set board size** ← Do this FIRST!
3. Place components (inside board area)
4. Route traces
5. Export

**Remember:**
- Board size = your working canvas
- Components must be **inside** that canvas
- Check coordinates make sense (e.g., for 100×80mm board, use x: 10-90, y: 10-70)

---

## 🎯 Quick Reference

| Board Size | Safe X Range | Safe Y Range | Center Point |
|------------|--------------|--------------|--------------|
| 50×40mm    | 10-40mm      | 10-30mm      | (25, 20)     |
| 80×60mm    | 10-70mm      | 10-50mm      | (40, 30)     |
| 100×80mm   | 10-90mm      | 10-70mm      | (50, 40)     |
| 150×100mm  | 10-140mm     | 10-90mm      | (75, 50)     |

---

**Remember: Board size first, components second!** 🎯
