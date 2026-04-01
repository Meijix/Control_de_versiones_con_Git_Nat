#!/usr/bin/env bash
# Demostracion: etiquetas ligeras y anotadas con git tag.
# Uso: bash demo-setup.sh

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEMO_DIR="${SCRIPT_DIR}/_demo-tag"

rm -rf "${DEMO_DIR}"
mkdir -p "${DEMO_DIR}"
cd "${DEMO_DIR}"

git init --initial-branch=main
git config user.name "Demo Tag"
git config user.email "demo.tag@example.local"

# --- Commit 1: inicializacion del proyecto ---
echo "# Mi Proyecto" > README.txt
git add README.txt
git commit -m "init: inicializacion del proyecto"

# --- Commit 2: modulo de usuarios ---
echo "modulo de gestion de usuarios" > users.txt
git add users.txt
git commit -m "feat(users): agregar modulo de usuarios"

# Guardamos el hash del commit 2 para la etiqueta ligera
COMMIT2_HASH="$(git rev-parse HEAD)"

# --- Commit 3: modulo de pedidos ---
echo "modulo de gestion de pedidos" > orders.txt
git add orders.txt
git commit -m "feat(orders): agregar modulo de pedidos"

# --- Commit 4: modulo de pagos ---
echo "modulo de gestion de pagos" > payments.txt
git add payments.txt
git commit -m "feat(payments): agregar modulo de pagos"

echo ""
echo "--- Historial de commits ---"
git log --oneline

# ============================================================
# 1. Crear etiqueta ligera v0.1.0 en el commit 2
# ============================================================
echo ""
echo "--- Creando etiqueta ligera v0.1.0 en el commit 2 (${COMMIT2_HASH:0:7}) ---"
git tag v0.1.0 "${COMMIT2_HASH}"

# ============================================================
# 2. Crear etiqueta anotada v1.0.0 en HEAD
# ============================================================
echo ""
echo "--- Creando etiqueta anotada v1.0.0 en HEAD ---"
git tag -a v1.0.0 -m "Release estable 1.0.0"

# ============================================================
# 3. Listar todas las etiquetas
# ============================================================
echo ""
echo "--- Listado de etiquetas (git tag -l) ---"
git tag -l

# ============================================================
# 4. Inspeccionar etiqueta anotada v1.0.0
# ============================================================
echo ""
echo "--- Inspeccionando etiqueta ANOTADA v1.0.0 (git show v1.0.0) ---"
echo "    (Muestra: tagger, fecha, mensaje del tag y datos del commit)"
echo ""
git show v1.0.0

# ============================================================
# 5. Inspeccionar etiqueta ligera v0.1.0
# ============================================================
echo ""
echo "--- Inspeccionando etiqueta LIGERA v0.1.0 (git show v0.1.0) ---"
echo "    (Muestra: solo los datos del commit, sin informacion extra del tag)"
echo ""
git show v0.1.0

# ============================================================
# 6. Explicacion de la diferencia
# ============================================================
echo ""
echo "============================================================"
echo " DIFERENCIA CLAVE"
echo "============================================================"
echo ""
echo "  Etiqueta LIGERA (v0.1.0):"
echo "    - Es solo un puntero al commit (como un alias)."
echo "    - No almacena autor, fecha ni mensaje propios."
echo "    - Util para marcas temporales o locales."
echo ""
echo "  Etiqueta ANOTADA (v1.0.0):"
echo "    - Crea un objeto Git independiente con autor (tagger),"
echo "      fecha y mensaje descriptivo."
echo "    - Recomendada para releases y versiones oficiales."
echo "    - Es la que se debe usar en flujos de CI/CD y publicacion."
echo ""
echo "============================================================"

# ============================================================
# 7. Eliminar etiqueta ligera v0.1.0
# ============================================================
echo ""
echo "--- Eliminando etiqueta v0.1.0 (git tag -d v0.1.0) ---"
git tag -d v0.1.0

# ============================================================
# 8. Verificar que solo queda v1.0.0
# ============================================================
echo ""
echo "--- Listado de etiquetas despues de eliminar v0.1.0 ---"
git tag -l

echo ""
echo "--- Historial final con decoracion de tags ---"
git log --oneline --decorate

echo ""
echo "Repositorio de demostracion en:"
echo "  ${DEMO_DIR}"
