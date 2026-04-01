#!/usr/bin/env bash
# Demostración: encontrar el commit que introdujo un error con git bisect.
# Uso: bash demo-setup.sh

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEMO_DIR="${SCRIPT_DIR}/_demo-bisect"

rm -rf "${DEMO_DIR}"
mkdir -p "${DEMO_DIR}"
cd "${DEMO_DIR}"

git init --initial-branch=main
git config user.name "Demo Bisect"
git config user.email "demo.bisect@example.local"

# --- Crear 8 commits; el commit 5 introduce un bug ---

echo "linea 1: inicio del proyecto" > app.txt
git add app.txt
git commit -m "feat: commit 1 - inicio del proyecto"

GOOD_HASH="$(git rev-parse HEAD)"

echo "linea 2: módulo de usuarios" >> app.txt
git add app.txt
git commit -m "feat: commit 2 - módulo de usuarios"

echo "linea 3: módulo de productos" >> app.txt
git add app.txt
git commit -m "feat: commit 3 - módulo de productos"

echo "linea 4: módulo de pedidos" >> app.txt
git add app.txt
git commit -m "feat: commit 4 - módulo de pedidos"

echo "linea 5: módulo de pagos" >> app.txt
echo "BUG: error critico" >> app.txt
git add app.txt
git commit -m "feat: commit 5 - módulo de pagos"

echo "linea 6: módulo de envíos" >> app.txt
git add app.txt
git commit -m "feat: commit 6 - módulo de envíos"

echo "linea 7: módulo de reportes" >> app.txt
git add app.txt
git commit -m "feat: commit 7 - módulo de reportes"

echo "linea 8: módulo de notificaciones" >> app.txt
git add app.txt
git commit -m "feat: commit 8 - módulo de notificaciones"

echo ""
echo "--- Historial completo (8 commits) ---"
git log --oneline

echo ""
echo "--- Contenido actual de app.txt ---"
cat app.txt

echo ""
echo "=== Iniciando git bisect ==="
echo ""
echo "Marcando HEAD como 'bad' (tiene el bug) y ${GOOD_HASH:0:7} como 'good' (sin bug)..."

git bisect start
git bisect bad HEAD
git bisect good "${GOOD_HASH}"

echo ""
echo "--- Ejecutando: git bisect run (búsqueda automática) ---"

# Crear script de test para bisect run.
# El script devuelve 0 (bueno) si NO encuentra "BUG:" en app.txt,
# y devuelve 1 (malo) si encuentra "BUG:" en app.txt.
cat > /tmp/bisect-test.sh <<'TESTEOF'
#!/usr/bin/env bash
! grep -q "BUG:" app.txt
TESTEOF
chmod +x /tmp/bisect-test.sh

git bisect run bash /tmp/bisect-test.sh

echo ""
echo "--- Resultado: el commit que introdujo el bug ha sido identificado arriba ---"

echo ""
echo "--- Ejecutando: git bisect reset ---"
git bisect reset

echo ""
echo "--- Historial final (de vuelta en main) ---"
git log --oneline

rm -f /tmp/bisect-test.sh

echo ""
echo "Repositorio de demostración en:"
echo "  ${DEMO_DIR}"
