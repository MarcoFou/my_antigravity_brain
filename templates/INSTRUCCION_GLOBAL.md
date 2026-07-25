# SISTEMA: GOOGLE ANTIGRAVITY - INSTRUCCIÓN GLOBAL DE ARQUITECTURA DUAL

**CONTEXTO DEL SISTEMA:**
El entorno de trabajo opera bajo una arquitectura de sincronización dividida para mantener la coherencia a través de múltiples PCs, optimizando el consumo de la suscripción Google AI Plus y previniendo la contaminación del contexto.
- **Cerebro Estructural (Lógica y Reglas):** Gestionado vía Git/GitHub en el repositorio privado `https://github.com/MarcoFou/my_antigravity_brain.git`.
- **Cerebro Dinámico (Estado y Memoria):** Gestionado vía Google Drive mediante enlaces simbólicos.
- **Workspace ID Activo:** `427f9d73-6715-470c-a8e5-f8fb11a2d5a1`

**DIRECTIVAS OBLIGATORIAS PARA LA GENERACIÓN DE CÓDIGO Y ARTEFACTOS:**

1. **Separación de Responsabilidades (Git vs. Drive):**
   - **Todo código fuente, reglas de agentes (`SKILL.md`), prompts base, configuraciones globales y arquitectura del proyecto** debe ser generado y modificado exclusivamente dentro de la ruta del repositorio Git localizado. Preparar todos estos archivos para ser confirmados (commit) de forma limpia.
   - **Los archivos de estado de sesión, logs, bases de datos temporales, cachés y artefactos de memoria conversacional** deben ser dirigidos y almacenados estrictamente en el directorio del "Cerebro Dinámico" (Ruta en PC1: `C:\Users\F1995\.gemini\antigravity\brain\427f9d73-6715-470c-a8e5-f8fb11a2d5a1`), el cual está enlazado a Google Drive.
   - **Nunca** generar archivos de memoria temporal dentro de la estructura de carpetas rastreada por Git.

2. **Organización de Proyectos y Sub-módulos:**
   - Cuando se solicite iniciar un nuevo proyecto o módulo (e.g., `urban_flow`), crear una estructura de directorios clara y modularizada dentro del entorno Git.
   - Utilizar convenciones de nomenclatura estándar (minúsculas, guiones bajos).
   - Generar siempre un archivo `.gitignore` robusto que excluya explícitamente cualquier directorio o archivo que deba pertenecer al "Cerebro Dinámico" en Google Drive, evitando la subida accidental de información de estado a GitHub.

3. **Mantenimiento del Contexto:**
   - Al recuperar información, priorizar las reglas y definiciones estructuradas alojadas en el repositorio Git (`my_antigravity_brain`).
   - Actualizar el contexto de forma continua pero registrar los cambios permanentes de lógica solo en los archivos que se versionarán, manteniendo la memoria de corto plazo en los artefactos de Drive.

4. **Operaciones Multi-PC:**
   - Asumir que el entorno de desarrollo cambiará entre máquinas. No codificar rutas absolutas (hardcoded) en los archivos del proyecto Git a menos que sea estrictamente necesario y se utilicen variables de entorno para manejar las diferencias entre `C:\Users\F1995` y otros perfiles de usuario.
   - Toda configuración de entorno debe ser fácilmente replicable mediante un `git pull` y la verificación de los enlaces simbólicos a Google Drive.

**MODO DE EJECUCIÓN:**
Reconocer y aplicar estas directivas en todas las interacciones futuras, organizando el trabajo y generando las respuestas de acuerdo a este modelo de arquitectura dual.
