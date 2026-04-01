#!/usr/bin/env bash
# Demostración: guardar trabajo temporal con git stash.
# Uso: bash demo-setup.sh

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEMO_DIR="${SCRIPT_DIR}/_demo-stash"

rm -rf "${DEMO_DIR}"
mkdir -p "${DEMO_DIR}"
cd "${DEMO_DIR}"

git init --initial-branch=main
git config user.name "Demo Stash"
git config user.email "demo.stash@example.local"

# ── 1. Commit inicial en main ──────────────────────────────────────

echo "# Proyecto Dashboard" > README.txt
echo "Aplicación de métricas internas." >> README.txt
echo "# Dashboard - placeholder" > dashboard.py
git add README.txt dashboard.py
git commit -m "docs: README inicial y estructura base del proyecto"

echo ""
echo "--- Commit inicial en main ---"
git log --oneline

# ── 2. Crear rama feature/dashboard y trabajar sin commitear ──────

git checkout -b feature/dashboard

# Modificar archivo existente (tracked) sin hacer commit
cat > dashboard.py <<'PYEOF'
def render_dashboard():
    print('Cargando widgets...')
    # TODO: conectar datos reales
PYEOF

echo ""
echo "--- Archivos modificados en feature/dashboard (sin commit) ---"
git status
git diff --stat

# ── 3. Guardar cambios con git stash ─────────────────────────────

echo ""
echo "--- Ejecutando: git stash push -m 'WIP: dashboard en progreso' ---"
git stash push -m "WIP: dashboard en progreso"

echo ""
echo "--- Estado del directorio después del stash (debe estar limpio) ---"
git status

echo ""
echo "--- Lista de stashes ---"
git stash list

# ── 4. Cambiar a main y aplicar hotfix ───────────────────────────

git checkout main

echo ""
echo "--- En main: aplicando hotfix ---"
echo "v1.0.1 - corrección crítica" > CHANGELOG.txt
git add CHANGELOG.txt
git commit -m "fix: corrección crítica en producción"

echo ""
echo "--- Historial de main después del hotfix ---"
git log --oneline

# ── 5. Volver a feature/dashboard y recuperar el stash ───────────

git checkout feature/dashboard

echo ""
echo "--- De vuelta en feature/dashboard ---"

echo ""
echo "--- Ejecutando: git stash pop ---"
git stash pop

echo ""
echo "--- Estado después del pop (cambios restaurados) ---"
git status

echo ""
echo "--- Contenido recuperado de dashboard.py ---"
cat dashboard.py

echo ""
echo "--- Lista de stashes (debe estar vacía) ---"
git stash list || true

echo ""
echo "Repositorio de demostración en:"
echo "  ${DEMO_DIR}"
