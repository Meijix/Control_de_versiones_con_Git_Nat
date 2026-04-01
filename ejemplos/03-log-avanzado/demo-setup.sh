#!/usr/bin/env bash
# Demostracion: opciones avanzadas de git log.
# Uso: bash demo-setup.sh

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEMO_DIR="${SCRIPT_DIR}/_demo-log-avanzado"

rm -rf "${DEMO_DIR}"
mkdir -p "${DEMO_DIR}"
cd "${DEMO_DIR}"

git init --initial-branch=main
git config user.name "Demo Log"
git config user.email "demo.log@example.local"

# ─── Commits del autor principal (Demo Log) ───

echo "# Mi Proyecto" > README.md
git add README.md
git commit -m "docs: README inicial del proyecto"

echo "def saludar():" > app.py
echo "    print('Hola mundo')" >> app.py
git add app.py
git commit -m "feat: funcion saludar en app.py"

echo "def despedir():" >> app.py
echo "    print('Adios')" >> app.py
git add app.py
git commit -m "feat: funcion despedir en app.py"

echo "# Configuracion" > config.txt
echo "debug=true" >> config.txt
git add config.txt
git commit -m "chore: archivo de configuracion inicial"

sed -i.bak 's/debug=true/debug=false/' config.txt && rm -f config.txt.bak
git add config.txt
git commit -m "fix: desactivar modo debug en produccion"

echo "## Instalacion" >> README.md
echo "pip install mi-proyecto" >> README.md
git add README.md
git commit -m "docs: instrucciones de instalacion en README"

# ─── Commits del colaborador ───

git config user.name "Colaborador"
git config user.email "colaborador@example.local"

echo "def test_saludar():" > test_app.py
echo "    assert saludar() is None" >> test_app.py
git add test_app.py
git commit -m "test: prueba unitaria para saludar"

echo "def validar_entrada(texto):" > utils.py
echo "    return texto.strip()" >> utils.py
git add utils.py
git commit -m "feat: funcion de validacion en utils.py"

echo "def test_validar():" >> test_app.py
echo "    assert validar_entrada('  hola  ') == 'hola'" >> test_app.py
git add test_app.py
git commit -m "test: prueba para validar_entrada"

echo "# Utilidades del proyecto" >> utils.py
git add utils.py
git commit -m "refactor: comentario descriptivo en utils.py"

# ─── Rama feature con commits adicionales (volver a Demo Log) ───

git config user.name "Demo Log"
git config user.email "demo.log@example.local"

git checkout -b feature/mejoras

echo "def calcular(a, b):" > calculadora.py
echo "    return a + b" >> calculadora.py
git add calculadora.py
git commit -m "feat: modulo calculadora con funcion calcular"

echo "TIMEOUT=30" >> config.txt
git add config.txt
git commit -m "fix: agregar timeout en configuracion"

# ─── Volver a main para las demostraciones ───

git checkout main

echo ""
echo "============================================="
echo "  DEMOSTRACION: Opciones avanzadas de git log"
echo "============================================="

echo ""
echo "--- 1. git log --oneline (vista compacta) ---"
git log --oneline

echo ""
echo "--- 2. git log --pretty=format (formato personalizado) ---"
echo "    Formato: hash_corto | autor | fecha_relativa | mensaje"
echo ""
git log --pretty=format:"%h %an %ar %s"

echo ""
echo ""
echo "--- 3. git log --author=\"Colaborador\" --oneline (filtrar por autor) ---"
git log --author="Colaborador" --oneline

echo ""
echo "--- 4. git log --grep=\"fix\" --oneline (buscar en mensajes) ---"
git log --grep="fix" --oneline

echo ""
echo "--- 5. git log --since=\"1 hour ago\" --oneline (filtrar por fecha) ---"
echo "    (Todos los commits aparecen porque se acaban de crear)"
echo ""
git log --since="1 hour ago" --oneline

echo ""
echo "--- 6. git log -S \"debug\" --oneline (pickaxe: buscar en cambios) ---"
echo "    (Muestra commits que anadieron o eliminaron la cadena \"debug\")"
echo ""
git log -S "debug" --oneline

echo ""
echo "--- 7. git log --oneline --graph --all (grafo con todas las ramas) ---"
git log --oneline --graph --all

echo ""
echo "============================================="
echo "  FIN DE LA DEMOSTRACION"
echo "============================================="
echo ""
echo "Repositorio de demostracion en:"
echo "  ${DEMO_DIR}"
