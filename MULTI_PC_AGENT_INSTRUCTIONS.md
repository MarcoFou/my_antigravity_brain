# Protocolo Obligatorio de Diagnóstico y Sincronización Multi-PC para Agentes de IA

> **DESTINATARIO:** Todo Agente de Inteligencia Artificial (Antigravity / Gemini) ejecutándose en una PC secundaria (PC2, Laptop, etc.) o cuando el usuario indique *"no veo las conversaciones ni proyectos de mi otra pc"* o *"sincroniza con nuestro brain global"*.
>
> **ESTÁNDAR DE EJECUCIÓN:** Estricto, determinista y sin margen de libre interpretación. Debes seguir estos pasos de forma secuencial exacta.

---

## 📌 Contexto Técnico del Problema

El ecosistema **Google Antigravity Dual Architecture** divide la información en dos canales:

1. **Cerebro Estructural (Git / GitHub):** Contiene el código fuente de los proyectos, documentación, reglas y scripts (`my_antigravity_brain`).
2. **Cerebro Dinámico (Google Drive):** Almacena dos elementos críticos:
   - **Workspaces (`AntigravityBrain`):** Carpetas de contexto con artefactos (`implementation_plan.md`, `walkthrough.md`), logs y scratchpad por cada ID de conversación.
   - **Historial de Conversaciones (`AntigravityConversations`):** Archivos de base de datos SQLite (`.db`) y Protobuf (`.pb`) que la interfaz gráfica de Antigravity lee para listar los chats anteriores.

Si el usuario no ve sus conversaciones o proyectos en una nueva PC, se debe a que:
- El script de enlace dual no se ha ejecutado en este equipo.
- Las bases de datos `.db/.pb` de `conversations` no se han descargado desde Google Drive.
- Los proyectos de código no han sido clonados/actualizados desde GitHub.

---

## 🤖 Protocolo de Ejecución Paso a Paso (Obligatorio para el Agente)

El agente **DEBE** ejecutar la siguiente secuencia exacta de comandos mediante la herramienta de terminal (`run_command`):

### Paso 1: Actualizar el Repositorio Estructural (Git Pull)
Navegar al repositorio central y descargar las últimas reglas y scripts:

```powershell
Set-Location "$env:USERPROFILE\.gemini\antigravity\scratch\my_antigravity_brain"
git status
git pull origin main
```

*Criterio de éxito:* El comando devuelve `Already up to date` o descarga commits recientes sin conflictos de fusión.

---

### Paso 2: Verificar Conexión a Google Drive
Verificar que la unidad de Google Drive para Escritorio esté montada y accesible en el sistema:

```powershell
Test-Path "G:\Mi unidad\AntigravityBrain"
Test-Path "G:\Mi unidad\AntigravityConversations"
```

*Criterio de éxito:* Ambos comandos devuelven `True`. Si devuelven `False`, notificar al usuario que Google Drive para Escritorio debe estar iniciado.

---

### Paso 3: Ejecutar el Setup de Enlace Dual Automático
Ejecutar el script automatizado que enlaza todos los brains de Google Drive y sincroniza el historial de conversaciones:

```powershell
powershell -ExecutionPolicy Bypass -File .\setup_dual_brain.ps1
```

*Lo que realiza automáticamente el script:*
1. Descarga e intercambia los archivos de historial `.db` y `.pb` entre `G:\Mi unidad\AntigravityConversations` y `$env:USERPROFILE\.gemini\antigravity\conversations`.
2. Escanea **todas** las carpetas de workspaces presentes en `G:\Mi unidad\AntigravityBrain` (ej. `1c14e2bd-...`, `fbe38590-...`, `427f9d73-...`, etc.).
3. Crea los enlaces de unión (`Junction Links`) correspondientes dentro de `$env:USERPROFILE\.gemini\antigravity\brain\` para cada workspace remoto.

*Criterio de éxito:* El script finaliza mostrando `SUCCESS: ¡Sincronización Dual Completa y Activa!`.

---

### Paso 4: Verificar la Integridad del Historial de Conversaciones
Comprobar que las bases de datos de chat están presentes localmente:

```powershell
Get-ChildItem "$env:USERPROFILE\.gemini\antigravity\conversations" -File | Select-Object Name, Length, LastWriteTime
```

*Criterio de éxito:* La lista incluye los archivos `.db` y `.pb` sincronizados desde Google Drive.

---

### Paso 5: Sincronizar Proyectos de Código (Cerebro Estructural)
Para garantizar que todos los proyectos de desarrollo estén disponibles en la PC secundaria:

1. Listar los proyectos existentes en la carpeta de desarrollo:
   ```powershell
   Get-ChildItem "$env:USERPROFILE\.gemini\antigravity\scratch" -Directory
   ```
2. Para cada proyecto versionado en Git que se encuentre en `scratch/` (ej. `my_antigravity_brain`, `AdaptiveMNQ`, etc.), ejecutar `git pull`:
   ```powershell
   git -C "$env:USERPROFILE\.gemini\antigravity\scratch\<NOMBRE_PROYECTO>" pull
   ```
3. Si el usuario menciona un proyecto de código específico que falta en esta PC:
   - Preguntar la URL del repositorio remoto de GitHub si no está registrada.
   - Clonar el proyecto en `$env:USERPROFILE\.gemini\antigravity\scratch\<NOMBRE_PROYECTO>`.

---

### Paso 6: Confirmación al Usuario y Notificación de Reinicio
Una vez completados los Pasos 1 a 5, el agente debe responder al usuario en **Español** con un resumen claro en Markdown indicando:

1. **Historial de Conversaciones:** Confirmar que todos los chats `.db/.pb` de Google Drive han sido sincronizados en la carpeta local.
2. **Workspaces Brain:** Listar las carpetas de workspace enlazadas mediante enlaces de unión (`Junction Links`).
3. **Proyectos Estructurales:** Confirmar el estado del repositorio Git y de los proyectos en `scratch/`.
4. **Instrucción de Reinicio:** **IMPORTANTE:** Indicar al usuario que debe reiniciar o recargar la aplicación/IDE Antigravity para que la interfaz re-indexe y muestre los historiales de conversación sincronizados.

---

## 🚫 Prohibiciones Absolutas para el Agente

1. **NUNCA** hacer `git add` ni `git commit` sobre la carpeta `brain/`, `conversations/`, archivos `.db`, `.pb`, `.log`, o `.jsonl`.
2. **NUNCA** modificar rutas usando caracteres o barras diagonales incompatibles con Windows sin usar variables de entorno (`$env:USERPROFILE`).
3. **NUNCA** asumir que una conversación no existe sin haber ejecutado `setup_dual_brain.ps1`.
