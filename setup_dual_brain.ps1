<#
.SYNOPSIS
    Script de configuración de Enlace Simbólico / Unión de Directorio (Junction) para la Arquitectura Dual de Google Antigravity.

.DESCRIPTION
    Crea la unión de directorio (Junction Link) entre la carpeta local de Antigravity Brain y el directorio de Google Drive sin requerir permisos de administrador.

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
    Write-Host "Creando carpeta en Drive: $targetDriveDir" -ForegroundColor Gray
    New-Item -ItemType Directory -Force -Path $targetDriveDir | Out-Null
    Write-Host "[OK] Directorio en Drive creado exitosamente." -ForegroundColor Green
} else {
    Write-Host "[OK] Directorio en Drive ya existe." -ForegroundColor Green
}

Write-Host "[2/3] Verificando ruta local de Antigravity Brain..." -ForegroundColor Yellow
$parentLocalDir = Split-Path $localBrainDir -Parent
if (-not (Test-Path $parentLocalDir)) {
    New-Item -ItemType Directory -Force -Path $parentLocalDir | Out-Null
}

if (Test-Path $localBrainDir) {
    $item = Get-Item $localBrainDir
    if ($item.Attributes -match "ReparsePoint") {
        Write-Host "[OK] El enlace (Junction/Symlink) ya existe en: $localBrainDir" -ForegroundColor Green
    } else {
        Write-Host "[INFO] Moviendo contenido local existente a Google Drive..." -ForegroundColor Gray
        Copy-Item -Path "$localBrainDir\*" -Destination $targetDriveDir -Recurse -Force -ErrorAction SilentlyContinue
        Remove-Item -Path $localBrainDir -Recurse -Force
    }
}

if (-not (Test-Path $localBrainDir)) {
    Write-Host "[3/3] Creando Enlace de Unión (Directory Junction)..." -ForegroundColor Yellow
    try {
        # Junction link funciona sin requerir permisos de administrador en Windows
        New-Item -ItemType Junction -Path $localBrainDir -Target $targetDriveDir -ErrorAction Stop | Out-Null
        Write-Host "==========================================================" -ForegroundColor Green
        Write-Host " SUCCESS: Enlace Creado Correctamente!                     " -ForegroundColor Green
        Write-Host " Local  : $localBrainDir                                  " -ForegroundColor Gray
        Write-Host " Target : $targetDriveDir                                 " -ForegroundColor Gray
        Write-Host "==========================================================" -ForegroundColor Green
    } catch {
        Write-Host "Intentando via cmd mklink /J..." -ForegroundColor Yellow
        cmd /c mklink /J "$localBrainDir" "$targetDriveDir"
    }
}
