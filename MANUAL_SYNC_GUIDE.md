# Guía de Sincronización Manual (Pull & Push) y Manual del Sistema

[![Google Antigravity](https://img.shields.io/badge/Google_Antigravity-Dual_Architecture-4285F4?style=for-the-badge&logo=google&logoColor=white)](https://github.com/MarcoFou/my_antigravity_brain.git)
[![Git Sync](https://img.shields.io/badge/Git-Pull_%26_Push-F05032?style=for-the-badge&logo=git&logoColor=white)](https://github.com/MarcoFou/my_antigravity_brain.git)
[![Google Drive](https://img.shields.io/badge/Google_Drive-Auto_Sync-34A853?style=for-the-badge&logo=googledrive&logoColor=white)](#)

Esta guía detalla el funcionamiento completo del sistema de **Arquitectura Dual de Google Antigravity** y proporciona instrucciones paso a paso para ejecutar las operaciones de `git pull`, `git push`, resolución de conflictos y mantenimiento del estado en entornos multi-PC.

---

## 📌 Visión General del Sistema y Flujo Global

El ecosistema Antigravity funciona con dos canales de sincronización independientes que operan en paralelo:

```mermaid
flowchart TD
    subgraph PC1 [Estación de Trabajo 1 (PC Principal)]
        AG1[Google Antigravity IDE/CLI]
        Git1[Cerebro Estructural: Git local]
        Drive1[Cerebro Dinámico: Junction Symlink]
        AG1 <-->|Código / Reglas| Git1
        AG1 <-->|Sesiones / Logs| Drive1
    end

    subgraph Cloud [Servicios en la Nube]
        GH[(GitHub: my_antigravity_brain)]
        GD[(Google Drive Sync)]
    end

    subgraph PC2 [Estación de Trabajo 2 (PC Secundaria)]
        AG2[Google Antigravity IDE/CLI]
        Git2[Cerebro Estructural: Git local]
        Drive2[Cerebro Dinámico: Junction Symlink]
        AG2 <-->|Código / Reglas| Git2
        AG2 <-->|Sesiones / Logs| Drive2
    end

    Git1 <-->|git pull / git push| GH
    Git2 <-->|git pull / git push| GH
    Drive1 <-->|Sync Silencioso en Background| GD
    Drive2 <-->|Sync Silencioso en Background| GD
```

### 🔑 Componentes y Parámetros del Sistema

| Parámetro | Valor por Defecto / Configuración |
| :--- | :--- |
| **Repositorio Remoto (GitHub)** | `https://github.com/MarcoFou/my_antigravity_brain.git` |
| **Workspace ID Activo** | `427f9d73-6715-470c-a8e5-f8fb11a2d5a1` |
| **Ruta Local de Cerebro Dinámico** | `$env:USERPROFILE\.gemini\antigravity\brain\427f9d73-6715-470c-a8e5-f8fb11a2d5a1` |
| **Ruta en Google Drive** | `G:\Mi unidad\AntigravityBrain\427f9d73-6715-470c-a8e5-f8fb11a2d5a1` |
| **Idioma Oficial de Operación** | Español (`es-ES` / `es-MX`) |

---

## 🔄 Flujo Operativo 1: Inicio de Sesión de Trabajo (PULL Manual)

Realiza este procedimiento **cada vez que inicies trabajo en una PC** antes de interactuar con el agente de Antigravity.

### Paso 1: Abrir Terminal y Navegar al Repositorio
Abre PowerShell o tu terminal preferida e ingresa al directorio del proyecto:

```powershell
cd "$env:USERPROFILE\.gemini\antigravity\scratch\my_antigravity_brain"
```

### Paso 2: Verificar el Estado Local
Asegúrate de que tu árbol de trabajo local esté limpio sin cambios pendientes no deseados:

```powershell
git status
```
*Si ves cambios no guardados que deseas conservar, haz commit primero. Si no los necesitas, descártalos.*

### Paso 3: Traer las Últimas Actualizaciones desde GitHub (`PULL`)
Ejecuta la sincronización con el repositorio remoto:

```powershell
git pull origin main
```
> [!NOTE]
> Esto descargará las últimas reglas de agentes (`SKILL.md`), configuraciones de arquitectura y actualizaciones de código creadas en la otra PC.

### Paso 4: Verificar la Conexión del Cerebro Dinámico (Google Drive)
Si es la primera vez que operas en esta PC o quieres asegurar la integración, ejecuta el script de enlace:

```powershell
.\setup_dual_brain.ps1
```
*El script verificará que el enlace de unión (`Junction Link`) entre la carpeta local de Antigravity y Google Drive esté activo.*

### Paso 5: Iniciar Antigravity
Abre Antigravity. La sesión leerá automáticamente la estructura actualizada de Git y mantendrá la memoria histórica desde Google Drive.

---

## 🚀 Flujo Operativo 2: Cierre de Sesión o Guardado de Hitos (PUSH Manual)

Realiza este procedimiento **al finalizar tu jornada de trabajo o al completar un módulo/regla importante**.

### Paso 1: Guardar Archivos en Antigravity
Asegúrate de que todos los archivos editados estén guardados en el editor.

### Paso 2: Revisar Cambios Detectados por Git
Consulta qué archivos fueron modificados en el Cerebro Estructural:

```powershell
git status
```

> [!CAUTION]
> **VERIFICACIÓN CRÍTICA:** Confirma que **NO** aparezcan carpetas como `brain/`, `logs/`, `.system_generated/`, o archivos `.jsonl` en la lista de cambios de Git. Esos archivos deben pertenecer exclusivamente a Google Drive.

### Paso 3: Seleccionar Archivos a Subir (`ADD`)
Agrega los cambios estructurales al área de preparación (*staging*):

```powershell
# Para agregar todos los cambios estructurales válidos:
git add .

# O para agregar un archivo específico:
git add README.md MANUAL_SYNC_GUIDE.md
```

### Paso 4: Crear Commit Atómico (`COMMIT`)
Registra el hito con un mensaje claro en español siguiendo la convención:

```powershell
git commit -m "docs: actualizar manual de sincronización y guía para PC secundaria"
```

### Paso 5: Enviar los Cambios a GitHub (`PUSH`)
Sube la nueva versión al repositorio remoto:

```powershell
git push origin main
```

---

## ☁️ Sincronización Automática de Memoria (Google Drive)

A diferencia del código (Git), la memoria dinámica y las conversaciones **NO requieren comandos de pull ni push**:
1. Google Drive para Escritorio detecta inmediatamente los cambios dentro de la carpeta `AntigravityBrain/`.
2. Antigravity escribe de manera continua sus logs y artefactos en el enlace simbólico local.
3. Al cambiar de PC, Google Drive descarga automáticamente los datos en segundo plano en pocos segundos.

---

## ⚠️ Resolución de Conflictos y Contingencias

### Escenario A: Cambios Locales Sin Subir en Ambas PCs (`Merge Conflict`)
Si hiciste cambios en la PC1 y olvidaste hacer `git pull` en la PC2 antes de editar:

1. **Guardar temporalmente los cambios de la PC2:**
   ```powershell
   git stash
   ```
2. **Descargar los cambios remotos:**
   ```powershell
   git pull --rebase origin main
   ```
3. **Re-aplicar tus cambios guardados:**
   ```powershell
   git stash pop
   ```
4. **Resolver conflictos si existen, hacer commit y push:**
   ```powershell
   git add .
   git commit -m "fix: resolver conflicto de sincronización entre PCs"
   git push origin main
   ```

### Escenario B: Reinstalar o Reparar el Enlace a Google Drive
Si Antigravity no encuentra las conversaciones anteriores en una PC:

```powershell
# Volver a ejecutar el script de enlace
.\setup_dual_brain.ps1 -WorkspaceId "427f9d73-6715-470c-a8e5-f8fb11a2d5a1" -DrivePath "G:\Mi unidad\AntigravityBrain"
```

---

## 🛠️ Resumen Rápido de Comandos Diarios

| Acción | Comando PowerShell |
| :--- | :--- |
| **Inicio de Jornada** | `cd $env:USERPROFILE\.gemini\antigravity\scratch\my_antigravity_brain; git pull origin main` |
| **Revisar Estado** | `git status` |
| **Guardar e Sincronizar Hito** | `git add . ; git commit -m "tipo: descripción" ; git push origin main` |
| **Reparar Enlace Drive** | `.\setup_dual_brain.ps1` |
