#!/usr/bin/env bash
# Demostración: crear y resolver un conflicto de merge.
# Uso: bash demo-setup.sh

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEMO_DIR="${SCRIPT_DIR}/_demo-merge-conflictos"

rm -rf "${DEMO_DIR}"
mkdir -p "${DEMO_DIR}"
cd "${DEMO_DIR}"

git init --initial-branch=main
git config user.name "Demo Merge"
git config user.email "demo.merge@example.local"

# ── 1. Commit base en main ────────────────────────────────────────────

printf '%s\n' "linea 1 original" "linea 2 original" "linea 3 original" > app.txt
git add app.txt
git commit -m "feat: archivo base con tres líneas"

echo ""
echo "--- Contenido inicial de app.txt ---"
cat app.txt

# ── 2. Rama feature/header: modifica la línea 1 ──────────────────────

git checkout -b feature/header

printf '%s\n' "linea 1 modificada por header" "linea 2 original" "linea 3 original" > app.txt
git add app.txt
git commit -m "feat(header): modifica línea 1 desde header"

echo ""
echo "--- Rama feature/header creada ---"
git log --oneline

# ── 3. Rama feature/footer: también modifica la línea 1 ──────────────

git checkout main
git checkout -b feature/footer

printf '%s\n' "linea 1 modificada por footer" "linea 2 original" "linea 3 original" > app.txt
git add app.txt
git commit -m "feat(footer): modifica línea 1 desde footer"

echo ""
echo "--- Rama feature/footer creada ---"
git log --oneline

# ── 4. Merge limpio: feature/header → main ────────────────────────────

git checkout main

echo ""
echo "--- Merge de feature/header en main (sin conflicto) ---"
git merge feature/header -m "merge: integrar feature/header en main"

echo ""
echo "--- app.txt después del primer merge ---"
cat app.txt

# ── 5. Merge con conflicto: feature/footer → main ─────────────────────

echo ""
echo "--- Merge de feature/footer en main (CONFLICTO esperado) ---"

set +e
git merge feature/footer -m "merge: integrar feature/footer en main"
MERGE_EXIT=$?
set -e

if [[ "${MERGE_EXIT}" -ne 0 ]]; then
  echo ""
  echo "--- El merge falló con código ${MERGE_EXIT} (conflicto detectado) ---"
fi

echo ""
echo "--- Contenido de app.txt con marcadores de conflicto ---"
cat app.txt

echo ""
echo "--- Estado del repositorio (archivos en conflicto) ---"
git status --short

# ── 6. Resolver el conflicto manualmente ───────────────────────────────

echo ""
echo "--- Resolviendo el conflicto: combinamos ambos cambios ---"

cat > app.txt << 'EOF'
linea 1 modificada por header y footer (combinado)
linea 2 original
linea 3 original
EOF

echo ""
echo "--- app.txt después de la resolución ---"
cat app.txt

git add app.txt
git commit -m "merge: resolver conflicto combinando header y footer"

# ── 7. Resultado final ────────────────────────────────────────────────

echo ""
echo "--- Historial final (git log --oneline --graph) ---"
git log --oneline --graph --all

echo ""
echo "--- Contenido final de app.txt ---"
cat app.txt

echo ""
echo "Repositorio de demostración en:"
echo "  ${DEMO_DIR}"
