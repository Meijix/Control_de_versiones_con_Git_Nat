#!/usr/bin/env bash
# Demostración: traer un commit concreto de otra rama con cherry-pick.
# Uso: bash demo-setup.sh

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEMO_DIR="${SCRIPT_DIR}/_demo-cherry-pick"

rm -rf "${DEMO_DIR}"
mkdir -p "${DEMO_DIR}"
cd "${DEMO_DIR}"

git init --initial-branch=main
git config user.name "Demo Cherry"
git config user.email "demo.cherry@example.local"

echo "contenido estable en producción" > README.txt
git add README.txt
git commit -m "docs: README inicial en main"

git checkout -b feature/login

echo "usuario" > login.txt
git add login.txt
git commit -m "feat(login): añade archivo de usuario"

echo "sesión" >> login.txt
git add login.txt
git commit -m "feat(login): gestión de sesión"

echo ""
echo "--- Rama feature/login (2 commits propios) ---"
git log main..HEAD --oneline

PICK_HASH="$(git rev-parse HEAD^)"
echo ""
echo "Hash del commit que solo añade login.txt (sin la línea de sesión): ${PICK_HASH}"

git checkout main

echo ""
echo "--- En main, antes del cherry-pick ---"
ls -la
git log --oneline

echo ""
echo "--- Aplicando: git cherry-pick ${PICK_HASH} ---"
git cherry-pick "${PICK_HASH}"

echo ""
echo "--- En main, después del cherry-pick ---"
git log --oneline --decorate
echo ""
cat login.txt 2>/dev/null || true

echo ""
echo "Repositorio de demostración en:"
echo "  ${DEMO_DIR}"
