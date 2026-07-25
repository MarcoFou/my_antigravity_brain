# Directivas Globales para Agentes de IA (Google Antigravity)

Este documento establece el **Prompt de Sistema, Racional de Sincronización y Reglas de Comportamiento** para los agentes de Inteligencia Artificial (Google Antigravity / Gemini) que operan dentro de este ecosistema.

---

## 🚨 Directivas Primarias

> **REGLA DE ORO:** Separa de forma absoluta el **Cerebro Estructural (Git)** del **Cerebro Dinámico (Google Drive)**. 
> 
> **PROHIBICIÓN ESTRICTA:** Bajo ninguna circunstancia el agente debe sugerir, ejecutar o automatizar comandos `git add` o `git commit` sobre historiales de chat, logs, cachés o archivos temporales.
> 
> **PROTOCOLO MULTI-PC OBLIGATORIO:** Al iniciar operaciones en una PC secundaria o cuando el usuario indique *"no veo las conversaciones ni proyectos de mi otra pc"* o *"sincroniza con nuestro brain global"*, el agente **DEBE** leer y ejecutar estrictamente el documento [MULTI_PC_AGENT_INSTRUCTIONS.md](./MULTI_PC_AGENT_INSTRUCTIONS.md).

---

## 💡 El Porqué de la Arquitectura (Racional de Sincronización)

- **GitHub (Cerebro Estructural):** Se utiliza *solo* para versionar hitos de desarrollo estático, código limpio, reglas de negocio y arquitecturas. No está diseñado para mutaciones constantes por segundo.
- **Google Drive (Cerebro Dinámico):** Realiza una sincronización silenciosa en segundo plano. Se encarga del "trabajo sucio" de mantener vivos los historiales de chat, cachés y el contexto temporal entre diferentes PCs sin requerir commits manuales ni generar conflictos de fusión (`merge conflicts`).

---

## 📜 Instrucciones Operativas Obligatorias

### 1. Separación Estricta de Responsabilidades
- **Cerebro Estructural:** Todo código fuente (`.py`, `.js`, `.cs`, `.html`, etc.), documentación oficial del software, prompts base y archivos de agentes (`SKILL.md`) **deben** ser generados dentro del repositorio Git para ser confirmados manualmente en hitos estables.
- **Cerebro Dinámico:** Los archivos de estado de sesión, logs, bases de datos temporales, cachés y artefactos de memoria conversacional cambiarán constantemente y **deben** almacenarse únicamente en el directorio del Cerebro Dinámico:
  `C:\Users\<USER>\.gemini\antigravity\brain\<WORKSPACE_ID>` (sincronizado silenciosamente por Google Drive).

### 2. Idioma Obligatorio
- **Todas las respuestas, análisis, comentarios en código y documentos generados DEBEN SER EN ESPAÑOL.**

### 3. Creación de Nuevos Módulos o Proyectos
Cuando el usuario solicite crear un nuevo sub-módulo (ejemplo: `urban_flow`, `trading_engine`, `analytics_dashboard`):
1. **Crear directorio modularizado** dentro del entorno Git usando nomenclatura en minúsculas con guiones bajos (`snake_case`).
2. **Generar obligatoriamente un `.gitignore` robusto** en la raíz del módulo descartando explícitamente:
   - Archivos de log (`*.log`, `logs/`).
   - Cachés y temporales (`.cache/`, `tmp/`, `__pycache__/`, `node_modules/`).
   - Artefactos o referencias al Cerebro Dinámico (`*.transcript.jsonl`, `brain/`).
3. **No codificar rutas absolutas** (`hardcoded paths`). Utilizar variables de entorno (`%USERPROFILE%`, `process.env.USERPROFILE`, etc.) o rutas relativas para facilitar la transición Multi-PC.

### 4. Mantenimiento del Contexto
- **Verdad Estructural:** Al consultar cómo debe funcionar el sistema o cuáles son sus reglas, lee primero la documentación y archivos en el repositorio Git (`my_antigravity_brain`).
- **Memoria Temporal:** Al registrar avances de la sesión actual, actualiza los artefactos almacenados en la carpeta del Cerebro Dinámico en Google Drive.
