#!/usr/bin/env bash
# check-upstream-changes.sh
# Compara el commit base (registrado en TRANSLATION_STATUS.md) con el upstream
# y muestra qué archivos de texto en inglés han cambiado y necesitan traducción.
#
# Uso:
#   ./check-upstream-changes.sh          # mostrar resumen
#   ./check-upstream-changes.sh --diff    # mostrar diffs detallados
#   ./check-upstream-changes.sh --update  # actualizar el commit base al upstream/master actual
#
# Requisitos previos (solo la primera vez):
#   git remote add upstream https://github.com/ImaterialC/PriconneRe-TL.git
#   git fetch upstream

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$ROOT_DIR"

STATUS_FILE="TRANSLATION_STATUS.md"
TEXT_PATH="src/BepInEx/Translation/en/Text"

# --- Extraer el commit base desde TRANSLATION_STATUS.md ---
BASE_COMMIT="$(grep -oP 'Commit base del upstream\*\* \| `\K[a-f0-9]{40}' "$STATUS_FILE" || true)"

if [[ -z "$BASE_COMMIT" ]]; then
  echo "❌ No se pudo encontrar el commit base en $STATUS_FILE"
  echo "   Busca la línea: **Commit base del upstream** | \`<hash de 40 caracteres>\`"
  exit 1
fi

# --- Comprobar que existe el remoto upstream ---
if ! git remote get-url upstream >/dev/null 2>&1; then
  echo "❌ El remoto 'upstream' no está configurado."
  echo "   Ejecuta primero:"
  echo "   git remote add upstream https://github.com/ImaterialC/PriconneRe-TL.git"
  exit 1
fi

echo "📡 Descargando últimos cambios del upstream..."
git fetch upstream --quiet

UPSTREAM_COMMIT="$(git rev-parse upstream/master)"
UPSTREAM_SHORT="$(git rev-parse --short upstream/master)"
BASE_SHORT="$(git rev-parse --short "$BASE_COMMIT")"

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Commit base (traducido):  $BASE_SHORT  ($BASE_COMMIT)"
echo "  Commit upstream (actual):  $UPSTREAM_SHORT  ($UPSTREAM_COMMIT)"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

if [[ "$BASE_COMMIT" == "$UPSTREAM_COMMIT" ]]; then
  echo "✅ Estás al día con el upstream. No hay cambios nuevos que traducir."
  exit 0
fi

# --- Listar archivos cambiados en en/Text ---
CHANGED_FILES="$(git diff --name-status "$BASE_COMMIT" "$UPSTREAM_COMMIT" -- "$TEXT_PATH/")"

if [[ -z "$CHANGED_FILES" ]]; then
  echo "✅ No hay cambios en los archivos de texto ($TEXT_PATH/) entre el commit base y el upstream."
  echo "   (Puede que haya cambios en otras partes del proyecto: BepInEx, dotnet, etc.)"
  echo ""
  echo "   Cambios totales entre los commits:"
  git diff --shortstat "$BASE_COMMIT" "$UPSTREAM_COMMIT"
  exit 0
fi

echo "📋 Archivos de texto modificados/añadidos que necesitan traducción:"
echo ""
git diff --name-status "$BASE_COMMIT" "$UPSTREAM_COMMIT" -- "$TEXT_PATH/" | \
  awk '{
    status = $1
    file = $2
    # Acortar la ruta para que sea más legible
    short = file
    sub(/^src\/BepInEx\/Translation\/en\/Text\//, "", short)
    if (status ~ /^A/) icon = "🆕"
    else if (status ~ /^M/) icon = "✏️ "
    else if (status ~ /^D/) icon = "🗑️ "
    else if (status ~ /^R/) icon = "🔄"
    else icon = "❓"
    printf "  %s  %-4s %s\n", icon, status, short
  }'
echo ""

# --- Estadísticas ---
TOTAL_FILES=$(echo "$CHANGED_FILES" | wc -l | tr -d ' ')
echo "📊 Total: $TOTAL_FILES archivo(s) con cambios en $TEXT_PATH/"
echo ""

# --- Modo --diff: mostrar diffs detallados ---
if [[ "${1:-}" == "--diff" ]]; then
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "  Diffs detallados (inglés)"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  git diff "$BASE_COMMIT" "$UPSTREAM_COMMIT" -- "$TEXT_PATH/"
  exit 0
fi

# --- Modo --update: actualizar el commit base ---
if [[ "${1:-}" == "--update" ]]; then
  echo "📝 Actualizando el commit base en $STATUS_FILE..."
  # Reemplazar el hash viejo por el nuevo
  if [[ "$(uname)" == "Darwin" ]]; then
    # macOS sed
    sed -i '' "s|$BASE_COMMIT|$UPSTREAM_COMMIT|g" "$STATUS_FILE"
    sed -i '' "s|$BASE_SHORT|$UPSTREAM_SHORT|g" "$STATUS_FILE"
  else
    # GNU sed
    sed -i "s|$BASE_COMMIT|$UPSTREAM_COMMIT|g" "$STATUS_FILE"
    sed -i "s|$BASE_SHORT|$UPSTREAM_SHORT|g" "$STATUS_FILE"
  fi
  echo "✅ Commit base actualizado a $UPSTREAM_SHORT ($UPSTREAM_COMMIT)"
  echo "   Recuerda haber traducido TODOS los cambios listados arriba antes de ejecutar --update."
  exit 0
fi

echo "💡 Para ver los diffs detallados:   ./check-upstream-changes.sh --diff"
echo "💡 Tras traducir todo, actualiza la base: ./check-upstream-changes.sh --update"
echo ""
echo "⚠️  Recordatorio: traduce solo el lado derecho (inglés → español),"
echo "   manteniendo intacta la clave japonesa (lado izquierdo de '=')."