#!/usr/bin/env bash
# Instala pre-commit.sample como .git/hooks/pre-commit en el cwd (debe ser un repo git).
# Uso: cd <repo-demo> && bash /ruta/a/install-hook.sh

set -euo pipefail

ROOT="$(git rev-parse --show-toplevel 2>/dev/null)" || {
  echo "Ejecuta este script dentro de un repositorio Git." >&2
  exit 1
}

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC="${SCRIPT_DIR}/pre-commit.sample"
DEST="${ROOT}/.git/hooks/pre-commit"

if [[ ! -f "${SRC}" ]]; then
  echo "No se encuentra ${SRC}" >&2
  exit 1
fi

cp "${SRC}" "${DEST}"
chmod +x "${DEST}"
echo "Instalado: ${DEST}"
