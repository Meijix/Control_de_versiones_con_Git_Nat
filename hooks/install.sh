#!/usr/bin/env bash
# Instala en el repositorio actual (directorio .git del cwd) los hooks de ejemplo.
# Uso:
#   bash hooks/install.sh              # pre-commit combinado + commit-msg + pre-push + prepare-commit-msg
#   bash hooks/install.sh format-only   # solo revisión de espacios (--check)
#   bash hooks/install.sh protect-only  # solo bloqueo de commits a main/master
#   bash hooks/install.sh pre-push-only # solo ejecución de pruebas antes de push
#   bash hooks/install.sh ticket-only   # solo auto-inserción de ticket en mensajes
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
    cp "${SCRIPT_DIR}/pre-push.run-tests.sample" "${HOOKS}/pre-push"
    chmod +x "${HOOKS}/pre-push"
    echo "Instalado: ${HOOKS}/pre-push  (ejecutar pruebas antes de push)"
    cp "${SCRIPT_DIR}/prepare-commit-msg.ticket.sample" "${HOOKS}/prepare-commit-msg"
    chmod +x "${HOOKS}/prepare-commit-msg"
    echo "Instalado: ${HOOKS}/prepare-commit-msg  (ticket desde nombre de rama)"
    ;;
  format-only)
    install_pre_commit "${SCRIPT_DIR}/pre-commit.format.sample"
    ;;
  protect-only)
    install_pre_commit "${SCRIPT_DIR}/pre-commit.protect-main.sample"
    ;;
  pre-push-only)
    cp "${SCRIPT_DIR}/pre-push.run-tests.sample" "${HOOKS}/pre-push"
    chmod +x "${HOOKS}/pre-push"
    echo "Instalado: ${HOOKS}/pre-push  (ejecutar pruebas antes de push)"
    ;;
  ticket-only)
    cp "${SCRIPT_DIR}/prepare-commit-msg.ticket.sample" "${HOOKS}/prepare-commit-msg"
    chmod +x "${HOOKS}/prepare-commit-msg"
    echo "Instalado: ${HOOKS}/prepare-commit-msg  (ticket desde nombre de rama)"
    ;;
  *)
    echo "Uso: bash hooks/install.sh [all|format-only|protect-only|pre-push-only|ticket-only]" >&2
    exit 1
    ;;
esac
