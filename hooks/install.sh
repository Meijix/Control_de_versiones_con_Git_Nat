#!/usr/bin/env bash
# Instala en el repositorio actual (directorio .git del cwd) los hooks de ejemplo.
# Uso:
#   bash hooks/install.sh              # pre-commit combinado + commit-msg Conventional Commits
#   bash hooks/install.sh format-only  # solo revisión de espacios (--check)
#   bash hooks/install.sh protect-only # solo bloqueo de commits a main/master
#
# Ejecutar desde la raíz del repositorio clonado.

set -euo pipefail

ROOT="$(git rev-parse --show-toplevel 2>/dev/null)" || {
  echo "Ejecuta este script dentro de un repositorio Git." >&2
  exit 1
}

HOOKS="${ROOT}/.git/hooks"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

mkdir -p "${HOOKS}"

mode="${1:-all}"

install_pre_commit() {
  local src="$1"
  cp "${src}" "${HOOKS}/pre-commit"
  chmod +x "${HOOKS}/pre-commit"
  echo "Instalado: ${HOOKS}/pre-commit  (desde $(basename "${src}"))"
}

case "${mode}" in
  all)
    install_pre_commit "${SCRIPT_DIR}/pre-commit.combined.sample"
    cp "${SCRIPT_DIR}/commit-msg.conventional-commits.sample" "${HOOKS}/commit-msg"
    chmod +x "${HOOKS}/commit-msg"
    echo "Instalado: ${HOOKS}/commit-msg  (Conventional Commits)"
    ;;
  format-only)
    install_pre_commit "${SCRIPT_DIR}/pre-commit.format.sample"
    ;;
  protect-only)
    install_pre_commit "${SCRIPT_DIR}/pre-commit.protect-main.sample"
    ;;
  *)
    echo "Uso: bash hooks/install.sh [all|format-only|protect-only]" >&2
    exit 1
    ;;
esac
