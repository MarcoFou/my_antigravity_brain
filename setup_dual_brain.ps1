<#
.SYNOPSIS
    Script de configuración de Enlace Simbólico / Unión de Directorio (Junction) para la Arquitectura Dual de Google Antigravity.

.DESCRIPTION
    1. Sincroniza los archivos de historial de conversaciones (.db/.pb) entre Google Drive y la carpeta local.
    2. Sincroniza y enlaza automáticamente TODAS las carpetas de workspaces 'brain' desde Google Drive.
    3. Permite que múltiples PCs compartan instantáneamente conversaciones, artefactos e historiales.

.PARAMETER DrivePath
    Ruta base del almacenamiento de brains en Google Drive (Por defecto: "G:\Mi unidad\AntigravityBrain").

.PARAMETER ConversationsDrivePath
    Ruta base del almacenamiento de conversaciones en Google Drive (Por defecto: "G:\Mi unidad\AntigravityConversations").
#>

[CmdletBinding()]
param(
    [string]$DrivePath = "G:\Mi unidad\AntigravityBrain",
    [string]$ConversationsDrivePath = "G:\Mi unidad\AntigravityConversations"
)

Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host " Google Antigravity - Setup Completo Arquitectura Dual    " -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan

# --- 1. SINCRO DE CONVERSACIONES (CHATS .DB/.PB) ---
Write-Host "[1/2] Sincronizando Conversaciones (.db/.pb) con Google Drive..." -ForegroundColor Yellow

$localConvDir = "$env:USERPROFILE\.gemini\antigravity\conversations"

if (-not (Test-Path $ConversationsDrivePath)) {
    Write-Host "Creando carpeta en Drive: $ConversationsDrivePath" -ForegroundColor Gray
    New-Item -ItemType Directory -Force -Path $ConversationsDrivePath | Out-Null
}

if (-not (Test-Path $localConvDir)) {
    New-Item -ItemType Directory -Force -Path $localConvDir | Out-Null
}

# A. Descargar conversaciones remotas desde Google Drive
if (Test-Path $ConversationsDrivePath) {
    Write-Host "Descargando historiales de conversaciones desde Drive..." -ForegroundColor Gray
    Get-ChildItem -Path $ConversationsDrivePath -File -ErrorAction SilentlyContinue | ForEach-Object {
        try {
            Copy-Item -Path $_.FullName -Destination $localConvDir -Force -ErrorAction SilentlyContinue
        } catch {}
    }
}

# B. Respaldar conversaciones locales hacia Google Drive
Write-Host "Respaldando conversaciones locales hacia Drive..." -ForegroundColor Gray
Get-ChildItem -Path $localConvDir -File -ErrorAction SilentlyContinue | ForEach-Object {
    try {
        Copy-Item -Path $_.FullName -Destination $ConversationsDrivePath -Force -ErrorAction SilentlyContinue
    } catch {}
}

# --- 2. SINCRO DE WORKSPACES BRAIN (ARTEFACTOS, LOGS, SCRATCH) ---
Write-Host "[2/2] Sincronizando Workspaces Brain con Google Drive..." -ForegroundColor Yellow

$localBrainBase = "$env:USERPROFILE\.gemini\antigravity\brain"

if (-not (Test-Path $DrivePath)) {
    New-Item -ItemType Directory -Force -Path $DrivePath | Out-Null
}

if (-not (Test-Path $localBrainBase)) {
    New-Item -ItemType Directory -Force -Path $localBrainBase | Out-Null
}

# A. Enlazar carpetas existentes en Google Drive
$driveWorkspaces = Get-ChildItem -Path $DrivePath -Directory -ErrorAction SilentlyContinue
foreach ($ws in $driveWorkspaces) {
    $wsId = $ws.Name
    $targetDriveDir = Join-Path $DrivePath $wsId
    $localWsDir = Join-Path $localBrainBase $wsId

    if (Test-Path $localWsDir) {
        $item = Get-Item $localWsDir
        if (-not ($item.Attributes -match "ReparsePoint")) {
            Copy-Item -Path "$localWsDir\*" -Destination $targetDriveDir -Recurse -Force -ErrorAction SilentlyContinue
            Remove-Item -Path $localWsDir -Recurse -Force -ErrorAction SilentlyContinue
            New-Item -ItemType Junction -Path $localWsDir -Target $targetDriveDir -ErrorAction SilentlyContinue | Out-Null
        }
    } else {
        Write-Host "Enlazando workspace remoto de Drive: $wsId" -ForegroundColor Gray
        New-Item -ItemType Junction -Path $localWsDir -Target $targetDriveDir -ErrorAction SilentlyContinue | Out-Null
    }
}

# B. Enlazar carpetas locales en Drive
$localWorkspaces = Get-ChildItem -Path $localBrainBase -Directory -ErrorAction SilentlyContinue
foreach ($lws in $localWorkspaces) {
    $wsId = $lws.Name
    $item = Get-Item $lws.FullName
    if (-not ($item.Attributes -match "ReparsePoint")) {
        $targetDriveDir = Join-Path $DrivePath $wsId
        if (-not (Test-Path $targetDriveDir)) {
            New-Item -ItemType Directory -Force -Path $targetDriveDir | Out-Null
        }
        Copy-Item -Path "$($lws.FullName)\*" -Destination $targetDriveDir -Recurse -Force -ErrorAction SilentlyContinue
        Remove-Item -Path $lws.FullName -Recurse -Force -ErrorAction SilentlyContinue
        New-Item -ItemType Junction -Path $lws.FullName -Target $targetDriveDir -ErrorAction SilentlyContinue | Out-Null
    }
}

Write-Host "==========================================================" -ForegroundColor Green
Write-Host " SUCCESS: ¡Sincronización Dual Completa y Activa!         " -ForegroundColor Green
Write-Host "==========================================================" -ForegroundColor Green
