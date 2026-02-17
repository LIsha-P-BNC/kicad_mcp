#!/usr/bin/env pwsh
# KiCAD MCP Server Diagnostic Script
# Run this to check if everything is set up correctly

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "KiCAD MCP Server Diagnostics" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

$errorList = @()
$warningList = @()

# 1. Check Node.js
Write-Host "[1/10] Checking Node.js..." -NoNewline
try {
    $nodeVersion = node --version 2>$null
    Write-Host " OK $nodeVersion" -ForegroundColor Green
} catch {
    Write-Host " FAIL Not found" -ForegroundColor Red
    $errorList += "Node.js is not installed or not in PATH"
}

# 2. Check npm
Write-Host "[2/10] Checking npm..." -NoNewline
try {
    $npmVersion = npm --version 2>$null
    Write-Host " OK $npmVersion" -ForegroundColor Green
} catch {
    Write-Host " FAIL Not found" -ForegroundColor Red
    $errorList +="npm is not installed or not in PATH"
}

# 3. Check project dependencies
Write-Host "[3/10] Checking project dependencies..." -NoNewline
if (Test-Path "C:\KiCAD-MCP-Server\node_modules") {
    Write-Host " OK Installed" -ForegroundColor Green
} else {
    Write-Host " FAIL Not installed" -ForegroundColor Red
    $errorList +="Run 'npm install' to install dependencies"
}

# 4. Check TypeScript build
Write-Host "[4/10] Checking TypeScript build..." -NoNewline
if (Test-Path "C:\KiCAD-MCP-Server\dist\index.js") {
    $buildTime = (Get-Item "C:\KiCAD-MCP-Server\dist\index.js").LastWriteTime
    Write-Host " OK Built ($buildTime)" -ForegroundColor Green
} else {
    Write-Host " FAIL Not built" -ForegroundColor Red
    $errorList +="Run 'npm run build' to compile TypeScript"
}

# 5. Check KiCAD installation
Write-Host "[5/10] Checking KiCAD installation..." -NoNewline
$kicadPath = "C:\Program Files\KiCad\9.0"
if (Test-Path $kicadPath) {
    Write-Host " OK Found at $kicadPath" -ForegroundColor Green
} else {
    Write-Host " FAIL Not found" -ForegroundColor Red
    $errorList +="KiCAD 9.0 not installed at $kicadPath"
}

# 6. Check KiCAD Python
Write-Host "[6/10] Checking KiCAD Python..." -NoNewline
$kicadPython = "C:\Program Files\KiCad\9.0\bin\python.exe"
if (Test-Path $kicadPython) {
    $pythonVersion = & $kicadPython --version 2>&1
    Write-Host " OK $pythonVersion" -ForegroundColor Green
} else {
    Write-Host " FAIL Not found" -ForegroundColor Red
    $errorList +="KiCAD Python not found at $kicadPython"
}

# 7. Check pcbnew module
Write-Host "[7/10] Checking pcbnew module..." -NoNewline
if (Test-Path $kicadPython) {
    try {
        $pcbnewTest = & $kicadPython -c "import pcbnew; print(pcbnew.Version())" 2>&1
        if ($LASTEXITCODE -eq 0) {
            Write-Host " OK Version: $pcbnewTest" -ForegroundColor Green
        } else {
            Write-Host " FAIL Import failed" -ForegroundColor Red
            $errorList +="pcbnew module cannot be imported: $pcbnewTest"
        }
    } catch {
        Write-Host " FAIL Import failed" -ForegroundColor Red
        $errorList +="pcbnew module cannot be imported"
    }
} else {
    Write-Host " SKIP Python not found" -ForegroundColor Yellow
}

# 8. Check Claude Desktop config
Write-Host "[8/10] Checking Claude Desktop config..." -NoNewline
$configPath = "$env:APPDATA\Claude\claude_desktop_config.json"
if (Test-Path $configPath) {
    try {
        $config = Get-Content $configPath -Raw | ConvertFrom-Json
        if ($config.mcpServers.kicad) {
            Write-Host " OK KiCAD MCP configured" -ForegroundColor Green

            # Verify the path in config
            $configuredPath = $config.mcpServers.kicad.args[0]
            if ($configuredPath -ne "C:\KiCAD-MCP-Server\dist\index.js") {
                $warningList +="Config path ($configuredPath) differs from expected path"
            }
        } else {
            Write-Host " WARN Not configured" -ForegroundColor Yellow
            $warningList +="KiCAD MCP not in Claude Desktop config"
        }
    } catch {
        Write-Host " FAIL Invalid JSON" -ForegroundColor Red
        $errorList +="Claude Desktop config is not valid JSON"
    }
} else {
    Write-Host " SKIP Not found" -ForegroundColor Yellow
    $warningList +="Claude Desktop config not found at $configPath"
}

# 9. Check Python interface
Write-Host "[9/10] Testing Python interface..." -NoNewline
if (Test-Path $kicadPython) {
    try {
        $testCommand = '{"command": "ping", "params": {}}'
        $result = $testCommand | & $kicadPython "C:\KiCAD-MCP-Server\python\kicad_interface.py" 2>$null
        if ($result -match '"success":\s*true') {
            Write-Host " OK Responding" -ForegroundColor Green
        } else {
            Write-Host " FAIL Not responding correctly" -ForegroundColor Red
            $errorList +="Python interface ping test failed"
        }
    } catch {
        Write-Host " FAIL Test failed" -ForegroundColor Red
        $errorList +="Python interface test failed: $_"
    }
} else {
    Write-Host " SKIP Python not found" -ForegroundColor Yellow
}

# 10. Check logs directory
Write-Host "[10/10] Checking logs..." -NoNewline
$logDir = "$env:USERPROFILE\.kicad-mcp\logs"
if (Test-Path $logDir) {
    $logFiles = Get-ChildItem $logDir -File
    Write-Host " OK $($logFiles.Count) log files" -ForegroundColor Green

    # Check for recent errors in logs
    $latestLog = Get-ChildItem "$logDir\kicad_interface.log" -ErrorAction SilentlyContinue
    if ($latestLog) {
        $recentErrors = Get-Content $latestLog.FullName -Tail 100 | Select-String -Pattern "\[ERROR\]"
        if ($recentErrors.Count -gt 0) {
            $warningList += "Found $($recentErrors.Count) recent errors in logs"
        }
    }
} else {
    Write-Host " SKIP No logs yet" -ForegroundColor Yellow
}

# Summary
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Summary" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

if ($errorList.Count -eq 0 -and $warningList.Count -eq 0) {
    Write-Host "All checks passed! MCP server is ready." -ForegroundColor Green
    Write-Host ""
    Write-Host "To start using:" -ForegroundColor Cyan
    Write-Host "1. Restart Claude Desktop completely"
    Write-Host "2. Look for KiCAD tools in the MCP tools section"
    Write-Host "3. Try: Create a new KiCAD project called Test"
} else {
    if ($errorList.Count -gt 0) {
        Write-Host ""
        Write-Host "Errors ($($errorList.Count)):" -ForegroundColor Red
        foreach ($err in $errorList) {
            Write-Host "  - $err" -ForegroundColor Red
        }
    }

    if ($warningList.Count -gt 0) {
        Write-Host ""
        Write-Host "Warnings ($($warningList.Count)):" -ForegroundColor Yellow
        foreach ($warn in $warningList) {
            Write-Host "  - $warn" -ForegroundColor Yellow
        }
    }

    Write-Host ""
    Write-Host "Recommended actions:" -ForegroundColor Cyan
    if ($errorList -match "npm install") {
        Write-Host "  1. Run: npm install" -ForegroundColor White
    }
    if ($errorList -match "npm run build") {
        Write-Host "  2. Run: npm run build" -ForegroundColor White
    }
    if ($errorList -match "KiCAD 9.0 not installed") {
        Write-Host "  3. Install KiCAD 9.0 from https://www.kicad.org/download/windows/" -ForegroundColor White
    }
    if ($warningList -match "Claude Desktop config") {
        Write-Host "  4. Configure Claude Desktop MCP server" -ForegroundColor White
    }
}

Write-Host ""
Write-Host "For more help, see TROUBLESHOOTING.md" -ForegroundColor Cyan
Write-Host ""
