# SISTEMA: GOOGLE ANTIGRAVITY - INSTRUCCIÓN GLOBAL DE ARQUITECTURA DUAL

**CONTEXTO DEL SISTEMA:**
El entorno de trabajo opera bajo una arquitectura de sincronización dividida para mantener la coherencia a través de múltiples PCs, optimizando el consumo de la suscripción Google AI Plus y previniendo la contaminación del contexto.
- **Cerebro Estructural (Lógica, Código y Reglas):** Gestionado vía Git/GitHub en el repositorio privado `https://github.com/MarcoFou/my_antigravity_brain.git`.
- **Cerebro Dinámico (Estado, Historiales y Memoria):** Gestionado exclusivamente vía Google Drive mediante enlaces simbólicos.
- **Workspace ID Activo:** `427f9d73-6715-470c-a8e5-f8fb11a2d5a1`

**EL PORQUÉ DE LA ARQUITECTURA (Racional de Sincronización):**
El sistema debe comprender la naturaleza de los archivos para no mezclar los flujos de trabajo:
- **GitHub** se utiliza *solo* para versionar hitos de desarrollo estático. No está diseñado para mutaciones constantes por segundo.
- **Google Drive** es estrictamente necesario porque realiza una sincronización silenciosa y en segundo plano. Se encarga del "trabajo sucio" de mantener vivos los historiales de chat y el contexto temporal entre las diferentes PCs sin requerir commits manuales ni generar conflictos de fusión (merge conflicts).

**DIRECTIVAS OBLIGATORIAS PARA LA GENERACIÓN DE CÓDIGO Y ARTEFACTOS:**

1. **Separación Estricta de Responsabilidades (Git vs. Drive):**
   - **Cerebro Estructural:** Todo código fuente, reglas de agentes (`SKILL.md`), prompts base, configuraciones globales y arquitectura del proyecto debe ser generado dentro del repositorio Git. Preparar estos archivos para ser confirmados (commit) de forma manual y limpia.
   - **Cerebro Dinámico:** Los archivos de estado de sesión, logs, bases de datos temporales, cachés y artefactos de memoria conversacional cambian constantemente. Deben ser almacenados *únicamente* en el directorio (Ruta en PC1: `C:\Users\F1995\.gemini\antigravity\brain\427f9d73-6715-470c-a8e5-f8fb11a2d5a1`), dejando que Google Drive se encargue de su sincronización.
   - **Prohibición Estricta:** Bajo ninguna circunstancia el agente debe sugerir, ejecutar o automatizar comandos `git add` o `git commit` sobre historiales de chat, logs o archivos temporales.

2. **Organización de Proyectos y Sub-módulos:**
   - Al iniciar un nuevo proyecto (e.g., `urban_flow`), crear una estructura de directorios modular dentro del entorno Git (usando minúsculas y guiones bajos).
   - Generar obligatoriamente un archivo `.gitignore` robusto que excluya explícitamente cualquier archivo de registro o estado conversacional, forzando a que esos datos residan solo en el dominio de Drive.

3. **Mantenimiento del Contexto:**
   - Al recuperar información, priorizar las reglas estructuradas en el repositorio Git.
   - Registrar los cambios permanentes de lógica solo en los archivos que se versionarán, manteniendo la memoria a corto plazo en los artefactos de Drive.

4. **Operaciones Multi-PC y Lenguaje:**
   - Asumir que el entorno cambiará entre máquinas. No codificar rutas absolutas en los archivos del proyecto Git (evitar el hardcoding de `C:\Users\F1995`) a menos que sea estrictamente necesario. Usar variables de entorno para facilitar la transición entre PCs.
   - Toda configuración de entorno debe ser funcional con solo hacer un `git pull` y teniendo el cliente de Google Drive activo.
   - **Idioma:** Responder y documentar siempre en español.

**MODO DE EJECUCIÓN:**
Reconocer, interiorizar y aplicar estas directivas en todas las interacciones. Organizar el trabajo, sugerir comandos y estructurar las respuestas respetando estrictamente esta separación entre el Cerebro Estructural (Git) y el Cerebro Dinámico (Drive).
