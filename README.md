# my_antigravity_brain

Repositorio central y privado para la sincronización y gestión de los agentes de Google Antigravity. 

Este entorno utiliza una arquitectura de sincronización dividida para evitar conflictos y optimizar el consumo de contexto en Google AI Plus:
*   **Git / GitHub:** Gestiona el "Cerebro Estructural" (código, reglas, extensiones, prompts base y archivos `.agents`).
*   **Google Drive:** Gestiona el "Cerebro Dinámico" (historiales de chat, estado de sesión y artefactos temporales) mediante enlaces simbólicos locales.

---

## ⚙️ Arquitectura de Directorios

*   **Usuario Principal:** `F1995`
*   **ID del Workspace/Cerebro:** `427f9d73-6715-470c-a8e5-f8fb11a2d5a1`
*   **Ruta Local:** `C:\Users\F1995\.gemini\antigravity\brain\427f9d73-6715-470c-a8e5-f8fb11a2d5a1`

---

## 🚀 Guía de Despliegue y Sincronización

### FASE 1: Configuración en la PC Principal (F1995)

1. **Subir estructura a GitHub:**
   Abrir terminal en el directorio del proyecto y ejecutar:
   ```bash
   git add .
   git commit -m "update: sincronización de cerebro estructural"
   git push origin main
