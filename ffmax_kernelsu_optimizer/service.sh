#!/system/bin/sh

# Este script se ejecuta como un servicio en segundo plano por KernelSU Next.
# Monitorea el estado de Free Fire Max y ajusta la resolución/densidad dinámicamente.

MODDIR=${0%/*}

log_print() {
  echo "FFMAX_OPTIMIZER_SERVICE: $1"
}

PACKAGE_NAME="com.dts.freefiremax"
TARGET_RESOLUTION="1440x3200"
TARGET_DENSITY="890"

log_print "🚀 Iniciando servicio de monitoreo para Free Fire Max..."

# Obtener la resolución y densidad originales de forma compatible
# Intentar varias formas para asegurar compatibilidad con diferentes versiones de Android y shells
ORIGINAL_RESOLUTION=$(wm size | grep -o 'Physical size: [0-9x]\+' | cut -d' ' -f3 || wm size | grep -o '[0-9x]\+' | head -n 1)
ORIGINAL_DENSITY=$(wm density | grep -o 'Physical density: [0-9]\+' | cut -d' ' -f3 || wm density | grep -o '[0-9]\+' | head -n 1)

# Si aún no se obtienen los valores, intentar una forma más genérica
if [ -z "$ORIGINAL_RESOLUTION" ]; then
    ORIGINAL_RESOLUTION=$(wm size | head -n 1 | cut -d' ' -f3)
fi
if [ -z "$ORIGINAL_DENSITY" ]; then
    ORIGINAL_DENSITY=$(wm density | head -n 1 | cut -d' ' -f3)
fi

log_print "💾 Resolución original detectada: ${ORIGINAL_RESOLUTION:-"Desconocida"}, Densidad original: ${ORIGINAL_DENSITY:-"Desconocida"}"
log_print "⏳ Esperando que Free Fire Max se inicie..."

GAME_ACTIVE=false

while true; do
    # Verificar si Free Fire Max está en primer plano
    # Usar dumpsys activity activities para mayor compatibilidad y grep -q para eficiencia
    if dumpsys activity activities | grep -q "$PACKAGE_NAME"; then
        if [ "$GAME_ACTIVE" = false ]; then
            log_print "🔥 Free Fire Max detectado. Aplicando configuración de juego (Resolución: $TARGET_RESOLUTION, Densidad/DPI: $TARGET_DENSITY)..."
            wm size "$TARGET_RESOLUTION"
            wm density "$TARGET_DENSITY"
            wm dpi "$TARGET_DENSITY" # Asumiendo que density y dpi son lo mismo aquí
            GAME_ACTIVE=true
            log_print "✅ Configuración de juego aplicada con éxito."
        fi
    else
        if [ "$GAME_ACTIVE" = true ]; then
            log_print "❄️ Free Fire Max cerrado. Restaurando configuración original..."
            # Solo restaurar si los valores originales no son desconocidos
            if [ "${ORIGINAL_RESOLUTION}" != "Desconocida" ]; then
                wm size "$ORIGINAL_RESOLUTION"
            fi
            if [ "${ORIGINAL_DENSITY}" != "Desconocida" ]; then
                wm density "$ORIGINAL_DENSITY"
                wm dpi "$ORIGINAL_DENSITY" # Restaurando dpi a la densidad original
            fi
            GAME_ACTIVE=false
            log_print "✅ Configuración original restaurada."
            log_print "💤 Monitoreo en pausa hasta el próximo inicio del juego..."
        fi
    fi
    sleep 5 # Esperar 5 segundos antes de volver a verificar
done
