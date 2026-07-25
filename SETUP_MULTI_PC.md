# Guía de Despliegue en Nuevas PCs (Multi-PC Setup)

Esta guía detalla los pasos para configurar un nuevo equipo de trabajo (PC2, PC3, Laptop, etc.) manteniendo la coherencia perfecta con la **Arquitectura Dual de Google Antigravity**.

---

## 📋 Requisitos Previos

1. **Git instalado** y configurado con credenciales de GitHub.
2. **Google Drive para Escritorio** instalado y sincronizando la unidad de red local (habitualmente unidad `G:\`).
3. **Google Antigravity CLI / IDE** instalado.

---

## 🛠️ Pasos de Configuración

### Paso 1: Clonar el Cerebro Estructural (Git)

Abre una terminal PowerShell y clona el repositorio central en tu directorio de trabajo o scratchpad:

```powershell
# Crear o navegar al directorio de trabajo
Set-Location "$env:USERPROFILE\.gemini\antigravity\scratch"

# Clonar el repositorio
git clone https://github.com/MarcoFou/my_antigravity_brain.git
cd my_antigravity_brain
```

---

### Paso 2: Crear el Enlace Simbólico al Cerebro Dinámico (Google Drive)

El Cerebro Dinámico almacena los estados de sesión y artefactos. Para enlazar la carpeta de Google Drive con la ubicación que busca Antigravity localmente:

#### Opción A: Usar el Script Automatizado (`setup_dual_brain.ps1`)

Ejecuta PowerShell como **Administrador** e invoca el script incluido:

```powershell
.\setup_dual_brain.ps1 -WorkspaceId "427f9d73-6715-470c-a8e5-f8fb11a2d5a1" -DrivePath "G:\Mi unidad\AntigravityBrain"
```

#### Opción B: Ejecución Manual de Comandos PowerShell / CMD

1. Define las rutas principales:
   ```powershell
   $workspaceId = "427f9d73-6715-470c-a8e5-f8fb11a2d5a1"
   $localBrainPath = "$env:USERPROFILE\.gemini\antigravity\brain\$workspaceId"
   $driveBrainPath = "G:\Mi unidad\AntigravityBrain\$workspaceId"
   ```

2. Asegúrate de que el directorio en Google Drive exista:
   ```powershell
   New-Item -ItemType Directory -Force -Path $driveBrainPath
   ```

3. Crea el enlace simbólico (requiere permisos de Administrador):
   ```powershell
   # En PowerShell
   New-Item -ItemType SymbolicLink -Path $localBrainPath -Target $driveBrainPath
   ```
   *(O usando `cmd.exe /c mklink /D "$localBrainPath" "$driveBrainPath"`)*

---

### Paso 3: Verificación de la Configuración

Para comprobar que el enlace simbólico y el repositorio están funcionando correctamente, ejecuta el siguiente diagnóstico en PowerShell:

```powershell
# Comprobar enlace simbólico
Get-Item "$env:USERPROFILE\.gemini\antigravity\brain\427f9d73-6715-470c-a8e5-f8fb11a2d5a1" | Select-Object Name, LinkType, Target

# Comprobar estado de Git
git status
```

**Resultado esperado:**  
- `LinkType`: `SymbolicLink`  
- `Target`: Apuntando a tu carpeta en Google Drive (`G:\Mi unidad\...`).

---

## 🔄 Flujo Diario de Trabajo Multi-PC

1. **Al iniciar en una PC:**
   ```powershell
   cd my_antigravity_brain
   git pull origin main
   ```
2. **Al trabajar con Antigravity:**
   El agente guardará automáticamente el estado dinámico en Google Drive y modificará el código en el repositorio Git.
3. **Al finalizar la jornada:**
   ```powershell
   git add .
   git commit -m "feat/docs: actualización de componentes estructurales"
   git push origin main
   ```
