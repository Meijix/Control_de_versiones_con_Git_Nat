#!/usr/bin/env bash
# Demostración: opciones avanzadas de git diff.
# Uso: bash demo-setup.sh

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEMO_DIR="${SCRIPT_DIR}/_demo-diff-avanzado"

rm -rf "${DEMO_DIR}"
mkdir -p "${DEMO_DIR}"
cd "${DEMO_DIR}"

git init --initial-branch=main
git config user.name "Demo Diff"
git config user.email "demo.diff@example.local"

# ──────────────────────────────────────────────
# Commit 1: archivo base con 4 líneas
# ──────────────────────────────────────────────

cat > app.txt <<'EOF'
linea 1: inicio
linea 2: configuracion
linea 3: funcionalidad
linea 4: cierre
EOF

git add app.txt
git commit -m "feat: archivo base de la aplicación"

# ──────────────────────────────────────────────
# Commit 2: modificar línea 2
# ──────────────────────────────────────────────

sed -i.bak 's/linea 2: configuracion/linea 2: configuracion actualizada/' app.txt
rm -f app.txt.bak
git add app.txt
git commit -m "feat: actualizar configuración"

# ──────────────────────────────────────────────
# Crear rama feature/mejoras y hacer 2 commits
# ──────────────────────────────────────────────

git checkout -b feature/mejoras

# Commit 3: mejorar funcionalidad
sed -i.bak 's/linea 3: funcionalidad/linea 3: funcionalidad mejorada/' app.txt
rm -f app.txt.bak
git add app.txt
git commit -m "feat: mejorar funcionalidad principal"

# Commit 4: añadir archivo de utilidades
cat > utils.txt <<'EOF'
utilidad 1: validar entrada
utilidad 2: formatear salida
utilidad 3: registrar eventos
EOF

git add utils.txt
git commit -m "feat: añadir archivo de utilidades"

# ──────────────────────────────────────────────
# Volver a main y hacer 1 commit
# ──────────────────────────────────────────────

git checkout main

# Commit 5: añadir documentación en main
cat > docs.txt <<'EOF'
Documentación del proyecto
==========================
Versión: 1.0
Última revisión: abril 2026
EOF

git add docs.txt
git commit -m "docs: añadir archivo de documentación"

echo ""
echo "=== Historial en main ==="
git log --oneline
echo ""
echo "=== Historial en feature/mejoras ==="
git log --oneline feature/mejoras

# ══════════════════════════════════════════════
# DEMO 1: Diff entre ramas (main..feature/mejoras)
# ══════════════════════════════════════════════

echo ""
echo "--- Diff entre ramas (main..feature/mejoras) ---"
echo "Muestra TODAS las diferencias entre las puntas de ambas ramas."
echo ""
git diff main..feature/mejoras

# ══════════════════════════════════════════════
# DEMO 2: Diff desde el punto de divergencia
# ══════════════════════════════════════════════

echo ""
echo "--- Diff desde el punto de divergencia (main...feature/mejoras) ---"
echo "Muestra solo los cambios en feature/mejoras desde el ancestro común."
echo ""
git diff main...feature/mejoras

# ══════════════════════════════════════════════
# DEMO 3: Resumen estadístico
# ══════════════════════════════════════════════

echo ""
echo "--- Resumen estadístico (--stat) ---"
echo ""
git diff main..feature/mejoras --stat

# ══════════════════════════════════════════════
# DEMO 4: Diff a nivel de palabra
# ══════════════════════════════════════════════

echo ""
echo "--- Diff a nivel de palabra (--word-diff) ---"
echo ""
git diff main..feature/mejoras --word-diff

# ══════════════════════════════════════════════
# DEMO 5: Solo nombres de archivos
# ══════════════════════════════════════════════

echo ""
echo "--- Solo nombres de archivos (--name-status) ---"
echo ""
git diff main..feature/mejoras --name-status

# ══════════════════════════════════════════════
# DEMO 6: Diff staged vs unstaged
# ══════════════════════════════════════════════

echo ""
echo "--- Diff staged vs unstaged ---"
echo ""

# Modificar app.txt sin hacer staging
sed -i.bak 's/linea 4: cierre/linea 4: cierre modificado localmente/' app.txt
rm -f app.txt.bak

echo ">>> Cambio en app.txt sin staging (git diff):"
echo ""
git diff

echo ""
echo ">>> Añadiendo al staging (git add app.txt)..."
git add app.txt

echo ""
echo ">>> Cambios ya en staging (git diff --staged):"
echo ""
git diff --staged

# ══════════════════════════════════════════════

echo ""
echo "Repositorio de demostración en:"
echo "  ${DEMO_DIR}"
