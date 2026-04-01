#!/usr/bin/env bash
# Demostración reproducible: rebase interactivo (squash de varios commits en uno).
# Uso: desde esta carpeta, ejecutar: bash demo-setup.sh

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEMO_DIR="${SCRIPT_DIR}/_demo-rebase-interactivo"

rm -rf "${DEMO_DIR}"
mkdir -p "${DEMO_DIR}"
cd "${DEMO_DIR}"

git init --initial-branch=main
git config user.name "Demo Rebase"
git config user.email "demo.rebase@example.local"

echo "v1" > app.txt
git add app.txt
git commit -m "feat: archivo base de la aplicación"

echo "v2" >> app.txt
git add app.txt
git commit -m "wip: avance temporal (debería fusionarse con el anterior)"

echo "v3" >> app.txt
git add app.txt
git commit -m "wip: otro avance (también fusionable)"

echo ""
echo "--- Estado antes del rebase (3 commits) ---"
git log --oneline

# Rebase interactivo sin editor manual: GIT_SEQUENCE_EDITOR edita la lista todo-in-one.
# Objetivo: mantener el primer commit como "pick" y marcar los dos siguientes como "squash"
# para unirlos al primero (Git abrirá editor para el mensaje combinado; lo evitamos con --no-edit si usamos fixup).
# Aquí usamos squash y mensaje fijo con GIT_EDITOR.

export GIT_SEQUENCE_EDITOR
GIT_SEQUENCE_EDITOR='sed -i.bak "2,3s/^pick/squash/"'

# macOS sed requiere extensión para -i; Linux acepta sed -i.bak igualmente.
if [[ "$(uname -s)" == "Darwin" ]]; then
  GIT_SEQUENCE_EDITOR='sed -i "" "2,3s/^pick/squash/"'
fi

export GIT_EDITOR
GIT_EDITOR='true'

echo ""
echo "--- Ejecutando: git rebase -i --root (equivale a editar los 3 commits desde el inicio; HEAD~3 fallaría si solo hay 3 commits) ---"
git rebase -i --root

echo ""
echo "--- Estado después del rebase (historial lineal, menos commits) ---"
git log --oneline --decorate

echo ""
echo "Repositorio de demostración en:"
echo "  ${DEMO_DIR}"
echo ""
echo "Para inspeccionar: cd \"${DEMO_DIR}\" && git log -p"
