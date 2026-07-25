<#
.SYNOPSIS
    Script de configuración de Enlace Simbólico para la Arquitectura Dual de Google Antigravity.

.DESCRIPTION
    Crea el enlace simbólico entre la carpeta local de Antigravity Brain y el directorio de Google Drive.

.PARAMETER WorkspaceId
    El ID del workspace activo (Por defecto: 427f9d73-6715-470c-a8e5-f8fb11a2d5a1).

.PARAMETER DrivePath
    Ruta base del almacenamiento en Google Drive (Por defecto: "G:\Mi unidad\AntigravityBrain").

.EXAMPLE
    .\setup_dual_brain.ps1 -WorkspaceId "427f9d73-6715-470c-a8e5-f8fb11a2d5a1" -DrivePath "G:\Mi unidad\AntigravityBrain"
#>

[CmdletBinding()]
param(
    [string]$WorkspaceId = "427f9d73-6715-470c-a8e5-f8fb11a2d5a1",
    [string]$DrivePath = "G:\Mi unidad\AntigravityBrain"
)

Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host " Google Antigravity - Setup de Arquitectura Dual Brain    " -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan

$localBrainDir = Join-Path "$env:USERPROFILE\.gemini\antigravity\brain" $WorkspaceId
$targetDriveDir = Join-Path $DrivePath $WorkspaceId

Write-Host "[1/3] Verificando directorio objetivo en Google Drive..." -ForegroundColor Yellow
if (-not (Test-Path $targetDriveDir)) {
    Write-Host "Creating target folder in Drive: $targetDriveDir" -ForegroundColor Gray
    New-Item -ItemType Directory -Force -Path $targetDriveDir | Out-Null
    Write-Host "✓ Directorio en Drive creado exitosamente." -ForegroundColor Green
} else {
    Write-Host "✓ Directorio en Drive ya existe." -ForegroundColor Green
}

Write-Host "[2/3] Verificando ruta local de Antigravity Brain..." -ForegroundColor Yellow
$parentLocalDir = Split-Path $localBrainDir -Parent
if (-not (Test-Path $parentLocalDir)) {
    New-Item -ItemType Directory -Force -Path $parentLocalDir | Out-Null
}

if (Test-Path $localBrainDir) {
    $item = Get-Item $localBrainDir
    if ($item.Attributes -match "ReparsePoint") {
        Write-Host "✓ El enlace simbólico ya existe en: $localBrainDir" -ForegroundColor Green
    } else {
        Write-Host "⚠️ Advertencia: Existe una carpeta física local en $localBrainDir." -ForegroundColor Red
        Write-Host "Respaldando carpeta local existente..." -ForegroundColor Gray
        $backupPath = "${localBrainDir}_backup_$(Get-Date -Format 'yyyyMMddHHmmss')"
        Move-Item -Path $localBrainDir -Destination $backupPath
        Write-Host "✓ Respaldado en: $backupPath" -ForegroundColor Green
    }
}

if (-not (Test-Path $localBrainDir)) {
    Write-Host "[3/3] Creando Enlace Simbólico (Symbolic Link)..." -ForegroundColor Yellow
    try {
        New-Item -ItemType SymbolicLink -Path $localBrainDir -Target $targetDriveDir -ErrorAction Stop | Out-Null
        Write-Host "==========================================================" -ForegroundColor Green
        Write-Host " SUCCESS: Enlace Simbólico Creado Correctamente!          " -ForegroundColor Green
        Write-Host " Local  : $localBrainDir                                  " -ForegroundColor Gray
        Write-Host " Target : $targetDriveDir                                 " -ForegroundColor Gray
        Write-Host "==========================================================" -ForegroundColor Green
    } catch {
        Write-Host "❌ Error al crear enlace simbólico: $_" -ForegroundColor Red
        Write-Host "Sugerencia: Ejecuta PowerShell como Administrador o activa el Modo Desarrollador en Windows." -ForegroundColor Yellow
    }
}
