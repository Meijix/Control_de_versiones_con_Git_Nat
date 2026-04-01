#!/usr/bin/env bash
# Demostración: trabajar en múltiples ramas con git worktree.
# Uso: bash demo-setup.sh

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEMO_DIR="${SCRIPT_DIR}/_demo-worktree"
HOTFIX_DIR="${DEMO_DIR}-hotfix"

rm -rf "${DEMO_DIR}"
rm -rf "${HOTFIX_DIR}"
mkdir -p "${DEMO_DIR}"
cd "${DEMO_DIR}"

git init --initial-branch=main
git config user.name "Demo Worktree"
git config user.email "demo.worktree@example.local"

# ──────────────────────────────────────────────
# 1. Commit inicial en main
# ──────────────────────────────────────────────

echo "Proyecto de ejemplo para demostrar git worktree" > README.txt
git add README.txt
git commit -m "docs: README inicial en main"

echo ""
echo "--- Commit inicial en main ---"
git log --oneline

# ──────────────────────────────────────────────
# 2. Crear rama feature/dashboard con un commit
# ──────────────────────────────────────────────

git checkout -b feature/dashboard

echo "Panel de métricas v1" > dashboard.txt
git add dashboard.txt
git commit -m "feat(dashboard): añade archivo inicial del panel"

echo ""
echo "--- Rama feature/dashboard (1 commit propio) ---"
git log main..HEAD --oneline

# ──────────────────────────────────────────────
# 3. Situación: trabajando en feature, llega un hotfix urgente
# ──────────────────────────────────────────────

echo ""
echo "=============================================="
echo "  SITUACIÓN: estás en feature/dashboard"
echo "  y llega un bug crítico en main."
echo "  En lugar de stash, usaremos git worktree."
echo "=============================================="
echo ""

# ──────────────────────────────────────────────
# 4. Crear un worktree para el hotfix en main
# ──────────────────────────────────────────────

echo "--- Creando worktree para el hotfix en main ---"
echo "Comando: git worktree add ${HOTFIX_DIR} main"
echo ""
git worktree add "${HOTFIX_DIR}" main

# ──────────────────────────────────────────────
# 5. Mostrar la lista de worktrees
# ──────────────────────────────────────────────

echo ""
echo "--- git worktree list (dos worktrees activos) ---"
git worktree list

# ──────────────────────────────────────────────
# 6. Ir al worktree del hotfix y hacer el fix
# ──────────────────────────────────────────────

echo ""
echo "--- Entrando al worktree del hotfix (${HOTFIX_DIR}) ---"
cd "${HOTFIX_DIR}"
echo ""
echo "Rama actual en el worktree del hotfix:"
git branch --show-current

echo ""
echo "--- Aplicando el hotfix en main ---"
echo "Corrección del bug crítico #42" > hotfix.txt
git add hotfix.txt
git commit -m "fix: corrige bug crítico #42 en producción"

echo ""
echo "Historial en main (worktree del hotfix):"
git log --oneline

# ──────────────────────────────────────────────
# 7. Volver al repositorio principal (feature/dashboard)
# ──────────────────────────────────────────────

echo ""
echo "--- Volviendo al repositorio principal (${DEMO_DIR}) ---"
cd "${DEMO_DIR}"
echo ""
echo "Rama actual en el repo principal:"
git branch --show-current

echo ""
echo "--- Tu trabajo en feature/dashboard sigue intacto ---"
cat dashboard.txt

# ──────────────────────────────────────────────
# 8. Mostrar que ambos directorios existen independientemente
# ──────────────────────────────────────────────

echo ""
echo "--- Ambos directorios coexisten ---"
echo "Repo principal (feature/dashboard):"
ls -la "${DEMO_DIR}"/*.txt
echo ""
echo "Worktree del hotfix (main):"
ls -la "${HOTFIX_DIR}"/*.txt

# ──────────────────────────────────────────────
# 9. Eliminar el worktree del hotfix
# ──────────────────────────────────────────────

echo ""
echo "--- Eliminando el worktree del hotfix ---"
echo "Comando: git worktree remove ${HOTFIX_DIR}"
echo ""
git worktree remove "${HOTFIX_DIR}"

# ──────────────────────────────────────────────
# 10. Verificar que solo queda el worktree principal
# ──────────────────────────────────────────────

echo ""
echo "--- git worktree list (solo queda el principal) ---"
git worktree list

echo ""
echo "--- El directorio del hotfix ya no existe ---"
if [ -d "${HOTFIX_DIR}" ]; then
  echo "  ${HOTFIX_DIR} todavía existe (inesperado)"
else
  echo "  ${HOTFIX_DIR} fue eliminado correctamente"
fi

# ──────────────────────────────────────────────
# Resumen final
# ──────────────────────────────────────────────

echo ""
echo "=============================================="
echo "  RESUMEN"
echo "  - Creaste un worktree para trabajar en main"
echo "    sin abandonar feature/dashboard."
echo "  - Hiciste el hotfix en un directorio aparte."
echo "  - Volviste a tu feature con todo intacto."
echo "  - Limpiaste el worktree con git worktree remove."
echo "=============================================="

echo ""
echo "Repositorio de demostración en:"
echo "  ${DEMO_DIR}"
