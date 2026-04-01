#!/usr/bin/env bash
# Demostración: recuperar commits perdidos con git reflog.
# Uso: bash demo-setup.sh

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEMO_DIR="${SCRIPT_DIR}/_demo-reflog"

rm -rf "${DEMO_DIR}"
mkdir -p "${DEMO_DIR}"
cd "${DEMO_DIR}"

git init --initial-branch=main
git config user.name "Demo Reflog"
git config user.email "demo.reflog@example.local"

# --- Paso 1: Crear tres commits ---

echo "v1" > app.txt
git add app.txt
git commit -m "feat: versión 1 de la aplicación"

echo "v2" >> app.txt
git add app.txt
git commit -m "feat: versión 2 — nueva funcionalidad"

echo "v3" >> app.txt
git add app.txt
git commit -m "feat: versión 3 — mejoras de rendimiento"

echo ""
echo "--- Historial completo (3 commits) ---"
git log --oneline

# --- Paso 2: Guardar el hash de HEAD antes de la operación destructiva ---

ORIGINAL_HEAD="$(git rev-parse HEAD)"

echo ""
echo "--- Ejecutando: git reset --hard HEAD~2 (se 'pierden' 2 commits) ---"
git reset --hard HEAD~2

echo ""
echo "--- Historial después del reset (solo queda 1 commit) ---"
git log --oneline

echo ""
echo "--- Los commits parecen perdidos, pero el reflog los recuerda ---"

echo ""
echo "--- git reflog ---"
git reflog

echo ""
echo "--- Recuperando commits: git reset --hard ${ORIGINAL_HEAD} ---"
git reset --hard "${ORIGINAL_HEAD}"

echo ""
echo "--- Historial restaurado (3 commits de nuevo) ---"
git log --oneline

echo ""
echo "Repositorio de demostración en:"
echo "  ${DEMO_DIR}"
