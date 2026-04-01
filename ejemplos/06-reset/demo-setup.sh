#!/usr/bin/env bash
# Demostración: diferencias entre git reset --soft, --mixed y --hard.
# Uso: bash demo-setup.sh

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEMO_DIR="${SCRIPT_DIR}/_demo-reset"

rm -rf "${DEMO_DIR}"
mkdir -p "${DEMO_DIR}"
cd "${DEMO_DIR}"

git init --initial-branch=main
git config user.name "Demo Reset"
git config user.email "demo.reset@example.local"

# ──────────────────────────────────────────────
# Crear 3 commits: app.txt con v1, v2, v3
# ──────────────────────────────────────────────

echo "versión 1" > app.txt
git add app.txt
git commit -m "feat: versión 1 de la aplicación"

echo "versión 2" > app.txt
git add app.txt
git commit -m "feat: versión 2 de la aplicación"

echo "versión 3" > app.txt
git add app.txt
git commit -m "feat: versión 3 de la aplicación"

echo ""
echo "=== Estado inicial (3 commits) ==="
git log --oneline

# ══════════════════════════════════════════════
# DEMO 1: git reset --soft
# ══════════════════════════════════════════════

echo ""
echo "--- DEMO 1: git reset --soft HEAD~1 ---"
echo ""

git reset --soft HEAD~1

echo ">>> git log --oneline (2 commits, el tercero desapareció del historial):"
git log --oneline

echo ""
echo ">>> git status (los cambios del tercer commit quedan STAGED):"
git status

echo ""
echo ">>> cat app.txt (el contenido sigue siendo versión 3):"
cat app.txt

echo ""
echo "--- Restaurando: re-commit para volver a 3 commits ---"
git commit -m "feat: versión 3 de la aplicación"
git log --oneline

# ══════════════════════════════════════════════
# DEMO 2: git reset --mixed (por defecto)
# ══════════════════════════════════════════════

echo ""
echo "--- DEMO 2: git reset HEAD~1 (equivale a --mixed) ---"
echo ""

git reset HEAD~1

echo ">>> git log --oneline (2 commits):"
git log --oneline

echo ""
echo ">>> git status (los cambios del tercer commit quedan NO STAGED):"
git status

echo ""
echo ">>> cat app.txt (el contenido sigue siendo versión 3):"
cat app.txt

echo ""
echo "--- Restaurando: git add + re-commit para volver a 3 commits ---"
git add app.txt
git commit -m "feat: versión 3 de la aplicación"
git log --oneline

# ══════════════════════════════════════════════
# DEMO 3: git reset --hard
# ══════════════════════════════════════════════

echo ""
echo "--- DEMO 3: git reset --hard HEAD~1 ---"
echo ""

git reset --hard HEAD~1

echo ">>> git log --oneline (2 commits):"
git log --oneline

echo ""
echo ">>> git status (directorio LIMPIO, sin cambios pendientes):"
git status

echo ""
echo ">>> cat app.txt (el contenido de versión 3 HA DESAPARECIDO):"
cat app.txt

echo ""
echo "=== Resumen ==="
echo "  --soft  : HEAD retrocede, cambios quedan en staging (listos para commit)."
echo "  --mixed : HEAD retrocede, cambios quedan en el directorio de trabajo (no staged)."
echo "  --hard  : HEAD retrocede, cambios se ELIMINAN del directorio de trabajo."
echo ""
echo "Repositorio de demostración en:"
echo "  ${DEMO_DIR}"
