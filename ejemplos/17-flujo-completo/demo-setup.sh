#!/usr/bin/env bash
# Demostración: flujo de trabajo completo simulando un día de desarrollo.
# Uso: bash demo-setup.sh

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEMO_DIR="${SCRIPT_DIR}/_demo-flujo-completo"

rm -rf "${DEMO_DIR}"
mkdir -p "${DEMO_DIR}"
cd "${DEMO_DIR}"

git init --initial-branch=main
git config user.name "Demo Flujo"
git config user.email "demo.flujo@example.local"

# ── 1. Commit inicial en main ─────────────────────────────────────────

echo ""
echo "=== Paso 1: Commit inicial en main ==="
echo ""

cat > README.md << 'EOF'
# Mi Proyecto
Aplicación de gestión de usuarios.
EOF

git add README.md
git commit -m "docs: README inicial del proyecto"

echo ""
echo "--- Contenido de README.md ---"
cat README.md

echo ""
echo "--- Historial en main ---"
git log --oneline

# ── 2. Crear rama feature/login ───────────────────────────────────────

echo ""
echo "=== Paso 2: Crear rama feature/login ==="
echo ""

git checkout -b feature/login

echo "Rama activa: $(git branch --show-current)"

# ── 3. Primer commit en la feature ────────────────────────────────────

echo ""
echo "=== Paso 3: Primer commit en feature/login (login.txt) ==="
echo ""

echo "formulario de login" > login.txt
git add login.txt
git commit -m "feat(login): añadir formulario básico de login"

echo ""
echo "--- Contenido de login.txt ---"
cat login.txt

echo ""
echo "--- Historial en feature/login ---"
git log --oneline

# ── 4. Segundo commit en la feature ───────────────────────────────────

echo ""
echo "=== Paso 4: Segundo commit en feature/login (validación) ==="
echo ""

echo "validación de sesión activa" >> login.txt
git add login.txt
git commit -m "feat(login): añadir validación de sesión"

echo ""
echo "--- Contenido de login.txt ---"
cat login.txt

echo ""
echo "--- Historial en feature/login ---"
git log --oneline

# ── 5. Cambio concurrente en main (simulando a otro compañero) ────────

echo ""
echo "=== Paso 5: Mientras tanto, un compañero modifica main ==="
echo ""

git checkout main

cat > README.md << 'EOF'
# Mi Proyecto
Aplicación de gestión de usuarios.
Versión: 0.9-beta
EOF

git add README.md
git commit -m "docs: añadir versión beta al README"

echo ""
echo "--- README.md en main (modificado por otro compañero) ---"
cat README.md

echo ""
echo "--- Historial en main ---"
git log --oneline

# ── 6. Volver a feature/login y sincronizar con main (CONFLICTO) ─────

echo ""
echo "=== Paso 6: Sincronizar feature/login con main (merge + conflicto) ==="
echo ""

git checkout feature/login

# Añadir una línea al README en la feature para provocar conflicto
cat > README.md << 'EOF'
# Mi Proyecto
Aplicación de gestión de usuarios.
Módulo de login integrado.
EOF

git add README.md
git commit -m "docs: actualizar README con info del módulo de login"

echo ""
echo "--- README.md en feature/login (antes del merge) ---"
cat README.md

echo ""
echo "--- Intentando: git merge main (traer cambios de main a la feature) ---"

set +e
git merge main -m "merge: traer cambios de main a feature/login"
MERGE_EXIT=$?
set -e

if [[ "${MERGE_EXIT}" -ne 0 ]]; then
  echo ""
  echo "--- CONFLICTO detectado (código de salida: ${MERGE_EXIT}) ---"
  echo ""
  echo "--- Contenido de README.md con marcadores de conflicto ---"
  cat README.md
  echo ""
  echo "--- Estado del repositorio ---"
  git status --short
fi

# ── 7. Resolver el conflicto ──────────────────────────────────────────

echo ""
echo "=== Paso 7: Resolver el conflicto combinando ambos cambios ==="
echo ""

cat > README.md << 'EOF'
# Mi Proyecto
Aplicación de gestión de usuarios.
Versión: 0.9-beta
Módulo de login integrado.
EOF

git add README.md
git commit -m "merge: resolver conflicto combinando cambios de main y feature"

echo ""
echo "--- README.md después de resolver el conflicto ---"
cat README.md

echo ""
echo "--- Historial en feature/login (ya sincronizada con main) ---"
git log --oneline --graph

# ── 8. Fusionar feature/login en main con --no-ff ─────────────────────

echo ""
echo "=== Paso 8: Fusionar feature/login en main (--no-ff) ==="
echo ""

git checkout main

git merge --no-ff feature/login -m "merge: integrar feature/login en main"

echo ""
echo "--- Merge completado ---"
echo ""
echo "--- Historial en main después del merge ---"
git log --oneline --graph

# ── 9. Crear etiqueta anotada v1.0.0 ──────────────────────────────────

echo ""
echo "=== Paso 9: Crear etiqueta anotada v1.0.0 ==="
echo ""

git tag -a v1.0.0 -m "Release 1.0.0 — login funcional"

echo "Etiqueta creada:"
git tag -l

echo ""
echo "--- Detalle de la etiqueta ---"
git show v1.0.0 --quiet

# ── 10. Historial final ───────────────────────────────────────────────

echo ""
echo "=== Paso 10: Historial final del proyecto ==="
echo ""

echo "--- git log --oneline --graph --all --decorate ---"
git log --oneline --graph --all --decorate

echo ""
echo "--- Archivos en el directorio de trabajo ---"
ls -la

echo ""
echo "--- Contenido final de README.md ---"
cat README.md

echo ""
echo "--- Contenido final de login.txt ---"
cat login.txt

# ── Fin ────────────────────────────────────────────────────────────────

echo ""
echo "============================================================"
echo " Flujo completo finalizado con éxito."
echo "============================================================"
echo ""
echo "Repositorio de demostración en:"
echo "  ${DEMO_DIR}"
