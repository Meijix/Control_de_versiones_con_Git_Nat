#!/usr/bin/env bash
# Demostración: rastrear autoría de cada línea con git blame.
# Uso: bash demo-setup.sh

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEMO_DIR="${SCRIPT_DIR}/_demo-blame"

rm -rf "${DEMO_DIR}"
mkdir -p "${DEMO_DIR}"
cd "${DEMO_DIR}"

git init --initial-branch=main
git config user.name "Demo Blame"
git config user.email "demo.blame@example.local"

# ── Commit 1: archivo de configuración inicial (Demo Blame) ──────────────────

cat > config.txt <<'EOF'
host=localhost
port=3000
debug=false
log_level=info
max_connections=10
EOF

git add config.txt
git commit -m "feat: crear archivo de configuración inicial"

# ── Commit 2: cambiar el puerto (Demo Blame) ─────────────────────────────────

if [[ "$(uname -s)" == "Darwin" ]]; then
  sed -i "" 's/port=3000/port=8080/' config.txt
else
  sed -i 's/port=3000/port=8080/' config.txt
fi

git add config.txt
git commit -m "config: cambiar puerto de 3000 a 8080"

# ── Cambio de autor: Colaborador Ejemplo ──────────────────────────────────────

git config user.name "Colaborador Ejemplo"
git config user.email "colaborador@example.local"

# ── Commit 3: activar debug y cambiar nivel de log (Colaborador Ejemplo) ─────

if [[ "$(uname -s)" == "Darwin" ]]; then
  sed -i "" 's/debug=false/debug=true/' config.txt
  sed -i "" 's/log_level=info/log_level=debug/' config.txt
else
  sed -i 's/debug=false/debug=true/' config.txt
  sed -i 's/log_level=info/log_level=debug/' config.txt
fi

git add config.txt
git commit -m "config: activar modo debug y nivel de log detallado"

# ── Cambio de autor: de vuelta a Demo Blame ───────────────────────────────────

git config user.name "Demo Blame"
git config user.email "demo.blame@example.local"

# ── Commit 4: añadir timeout (Demo Blame) ────────────────────────────────────

echo "timeout=30" >> config.txt

git add config.txt
git commit -m "config: añadir configuración de timeout"

# ── Mostrar historial ────────────────────────────────────────────────────────

echo ""
echo "--- Historial de commits (git log --oneline) ---"
git log --oneline

# ── git blame completo ───────────────────────────────────────────────────────

echo ""
echo "--- git blame config.txt (autoría de cada línea) ---"
git blame config.txt

# ── git blame con rango de líneas ─────────────────────────────────────────────

echo ""
echo "--- git blame -L 2,4 config.txt (solo líneas 2-4) ---"
git blame -L 2,4 config.txt

echo ""
echo "Repositorio de demostración en:"
echo "  ${DEMO_DIR}"
