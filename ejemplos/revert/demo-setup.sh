#!/usr/bin/env bash
# Demostracion: deshacer un commit de forma segura con git revert.
# Uso: bash demo-setup.sh

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEMO_DIR="${SCRIPT_DIR}/_demo-revert"

rm -rf "${DEMO_DIR}"
mkdir -p "${DEMO_DIR}"
cd "${DEMO_DIR}"

git init --initial-branch=main
git config user.name "Demo Revert"
git config user.email "demo.revert@example.local"

# --- Commit 1: funcionalidad base ---
# Se crea el archivo con varias secciones separadas para que los cambios
# posteriores no generen conflictos al revertir (los hunks no se solapan).
cat > app.txt <<'CONTENIDO'
# Aplicacion Demo
#
# Seccion A: funcionalidad base
linea 1: funcionalidad base
#
# Seccion B: reservada
#
# Seccion C: reservada
CONTENIDO
git add app.txt
git commit -m "feat: funcionalidad base en app.txt"

# --- Commit 2: cambio problematico ---
# Se modifica la seccion B (zona central del archivo).
cat > app.txt <<'CONTENIDO'
# Aplicacion Demo
#
# Seccion A: funcionalidad base
linea 1: funcionalidad base
#
# Seccion B: cambio problematico
linea 2: cambio problematico
#
# Seccion C: reservada
CONTENIDO
git add app.txt
git commit -m "feat: agregar cambio problematico"

# --- Commit 3: nueva funcionalidad ---
# Se modifica la seccion C (zona final del archivo), lejos del cambio problematico.
cat > app.txt <<'CONTENIDO'
# Aplicacion Demo
#
# Seccion A: funcionalidad base
linea 1: funcionalidad base
#
# Seccion B: cambio problematico
linea 2: cambio problematico
#
# Seccion C: nueva funcionalidad
linea 3: nueva funcionalidad
CONTENIDO
git add app.txt
git commit -m "feat: nueva funcionalidad"

echo ""
echo "--- Historial antes del revert (3 commits) ---"
git log --oneline

echo ""
echo "--- Contenido de app.txt antes del revert ---"
cat app.txt

# Capturar el hash del commit 2 (HEAD~1 = el commit anterior al ultimo)
REVERT_HASH="$(git rev-parse HEAD~1)"

echo ""
echo "--- Hash del commit problematico a revertir: ${REVERT_HASH} ---"

echo ""
echo "--- Ejecutando: git revert ${REVERT_HASH} --no-edit ---"
git revert "${REVERT_HASH}" --no-edit

echo ""
echo "--- Historial despues del revert (4 commits, revert agregado) ---"
git log --oneline

echo ""
echo "--- Contenido de app.txt despues del revert ---"
cat app.txt

echo ""
echo "Nota: la linea 2 (cambio problematico) fue eliminada."
echo "Las lineas 1 y 3 se preservan intactas."

echo ""
echo "Repositorio de demostracion en:"
echo "  ${DEMO_DIR}"
