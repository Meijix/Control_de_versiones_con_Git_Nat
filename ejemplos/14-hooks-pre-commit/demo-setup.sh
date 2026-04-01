#!/usr/bin/env bash
# Crea un repo demo, instala el hook pre-commit y muestra un commit bloqueado vs uno válido.
# Uso: bash demo-setup.sh

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEMO_DIR="${SCRIPT_DIR}/_demo-hooks-precommit"

rm -rf "${DEMO_DIR}"
mkdir -p "${DEMO_DIR}"
cd "${DEMO_DIR}"

git init --initial-branch=main
git config user.name "Demo Hooks"
git config user.email "demo.hooks@example.local"

bash "${SCRIPT_DIR}/install-hook.sh"

echo "ok" > limpio.txt
git add limpio.txt
git commit -m "chore: commit inicial"

echo ""
echo "--- Intento de commit CON marcadores de conflicto (debe FALLAR) ---"
printf '%s\n' '<<<<<<< HEAD' 'cambio local' '=======' 'cambio entrante' '>>>>>>> rama' > mal.txt
git add mal.txt
set +e
git commit -m "esto no debería pasar"
FAIL=$?
set -e
if [[ "${FAIL}" -eq 0 ]]; then
  echo "ERROR: el hook debería haber rechazado el commit." >&2
  exit 1
fi
git reset HEAD mal.txt
rm -f mal.txt

echo ""
echo "--- Commit sin conflictos (debe OK) ---"
echo "bien" >> limpio.txt
git add limpio.txt
git commit -m "docs: actualiza archivo limpio"

echo ""
echo "Historial:"
git log --oneline

echo ""
echo "Repositorio de demostración en:"
echo "  ${DEMO_DIR}"
