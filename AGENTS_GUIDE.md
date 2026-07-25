# Directivas Globales para Agentes de IA (Google Antigravity)

Este documento sirve como el **Prompt de Sistema y Marco de Reglas de Comportamiento** para los agentes de Inteligencia Artificial (Google Antigravity / Gemini) que operan dentro de este ecosistema.

---

## 🚨 Directiva Primaria

> **REGLA DE ORO:** Separa de forma absoluta el **Cerebro Estructural (Git)** del **Cerebro Dinámico (Google Drive)**. Nunca guardes archivos de sesión, logs, cachés o artefactos de memoria temporal dentro de la estructura rastreada por Git.

---

## 📜 Instrucciones Operativas Obligatorias

### 1. Separación de Responsabilidades
- **Código y Reglas deterministas:** Todo código fuente (`.py`, `.js`, `.cs`, `.html`, etc.), documentación oficial del software, prompts base y archivos de agentes (`SKILL.md`) **deben** ser generados dentro de la estructura Git y preparados para commit.
- **Memoria y Estado:** Todo archivo de estado, logs, borradores temporales (`scratch/`), planes de implementación (`implementation_plan.md`) y walkthroughs (`walkthrough.md`) **deben** dirigirse exclusivamente al directorio del Cerebro Dinámico:
  `C:\Users\<USER>\.gemini\antigravity\brain\<WORKSPACE_ID>` (enlazado a Google Drive).

### 2. Creación de Nuevos Módulos o Proyectos
Cuando el usuario solicite crear un nuevo sub-módulo (ejemplo: `urban_flow`, `trading_engine`, `analytics_dashboard`):
1. **Crear directorio modularizado** dentro del entorno Git usando nomenclatura en minúsculas con guiones bajos (`snake_case`).
2. **Generar un `.gitignore` exclusivo** en la raíz del módulo descartando explícitamente:
   - Archivos de log (`*.log`, `logs/`).
   - Cachés y temporales (`.cache/`, `tmp/`, `__pycache__/`, `node_modules/`).
   - Artefactos o referencias al Cerebro Dinámico.
3. **No codificar rutas absolutas** (`hardcoded paths`). Utilizar variables de entorno (`%USERPROFILE%`, `process.env.USERPROFILE`, etc.) o rutas relativas.

### 3. Recuperación de Contexto y Decisión
- **Verdad Estructural:** Al consultar cómo debe funcionar el sistema o cuáles son sus reglas, lee primero la documentación y archivos en el repositorio Git (`my_antigravity_brain`).
- **Memoria Temporal:** Al registrar avances de la sesión actual, actualiza los artefactos almacenados en la carpeta del Cerebro Dinámico en Google Drive.

### 4. Flujo de Trabajo en Planning Mode
Cuando operes en Planning Mode:
- Genera el `implementation_plan.md` en el directorio de artefactos del Cerebro Dinámico (`.gemini/antigravity/brain/<WORKSPACE_ID>/implementation_plan.md`).
- Establece metadata con `user_facing: true` y `request_feedback: true`.
- Presenta el resumen al usuario y aguarda confirmación previa a la ejecución de cambios estructurales en el repositorio Git.

---

## 🤖 Plantilla de Prompt de Inicialización (System Prompt Injection)

Al iniciar una nueva sesión de desarrollo, incluye o verifica que la siguiente instrucción esté activa:

```markdown
# SISTEMA: GOOGLE ANTIGRAVITY - INSTRUCCIÓN GLOBAL DE ARQUITECTURA DUAL
- Cerebro Estructural: Repositorio Git https://github.com/MarcoFou/my_antigravity_brain.git
- Cerebro Dinámico: Google Drive vía enlace simbólico en .gemini/antigravity/brain/427f9d73-6715-470c-a8e5-f8fb11a2d5a1
- Workspace ID Activo: 427f9d73-6715-470c-a8e5-f8fb11a2d5a1

DIRECTIVAS:
1. Todo código fuente y SKILL.md se guarda exclusivamente en Git.
2. Todo log, caché, plan y borrador se guarda en el Cerebro Dinámico de Google Drive.
3. Prohibido usar rutas absolutas hardcoded.
4. Generar siempre .gitignore robustos en cada sub-módulo.
```
