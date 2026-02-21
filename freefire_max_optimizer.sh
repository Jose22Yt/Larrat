#!/system/bin/sh
# Script de Optimización Avanzada para Free Fire Max (Brevent Console)
# Creado por Manus AI

# Este script aplica varias configuraciones del sistema Android a través de comandos ADB
# para mejorar el rendimiento, la fluidez y la sensibilidad en Free Fire Max.
# También incluye un monitoreo en tiempo real para ajustar la resolución, densidad y DPI
# automáticamente al abrir y cerrar el juego.
# Se recomienda ejecutar este script a través de la consola de Brevent.

# --- ADVERTENCIA ---
# Algunas configuraciones pueden variar en su efecto o compatibilidad dependiendo del modelo de tu dispositivo Android y la versión del sistema operativo.
# Si experimentas algún comportamiento inesperado, puedes reiniciar tu dispositivo para revertir la mayoría de los cambios.
# Utiliza este script bajo tu propia responsabilidad.

PACKAGE_NAME="com.dts.freefiremax"
TARGET_RESOLUTION="1440x3200"
TARGET_DENSITY="890"

echo "Iniciando optimización para Free Fire Max..."

# 1. Optimización de la Tasa de Refresco (120Hz/FPS)
settings put system min_refresh_rate 0
settings put system peak_refresh_rate 0
echo "Tasa de refresco ajustada para máxima fluidez."

# 2. Optimización de la Velocidad del Puntero y Sensibilidad Táctil
settings put system pointer_speed 7
settings put system touch_sensitivity 2
settings put secure long_press_timeout 250
settings put secure multi_press_timeout 250
echo "Velocidad del puntero y sensibilidad táctil ajustadas."

# 3. Optimización de las Escalas de Animación (Fluidez de la UI)
settings put global window_animation_scale 0.5
settings put global transition_animation_scale 0.5
settings put global animator_duration_scale 0.5
echo "Escalas de animación del sistema reducidas para mayor agilidad."

# 4. Otras Optimizaciones Generales
settings put system show_touches 0
echo "Visualización de toques desactivada."

# --- Monitoreo en Tiempo Real para Resolución y DPI ---

echo "Iniciando monitoreo en tiempo real para Free Fire Max..."

# Obtener la resolución y densidad originales
ORIGINAL_RESOLUTION=$(wm size | grep -oP '(?<=Physical size: )\S+' || wm size | grep -oP '(?<=Current size: )\S+')
ORIGINAL_DENSITY=$(wm density | grep -oP '(?<=Physical density: )\S+' || wm density | grep -oP '(?<=Current density: )\S+')

if [ -z "$ORIGINAL_RESOLUTION" ]; then
    ORIGINAL_RESOLUTION="$(wm size | awk '{print $3}')"
fi
if [ -z "$ORIGINAL_DENSITY" ]; then
    ORIGINAL_DENSITY="$(wm density | awk '{print $3}')"
fi

echo "Resolución original: $ORIGINAL_RESOLUTION, Densidad original: $ORIGINAL_DENSITY"

GAME_ACTIVE=false

while true; do
    CURRENT_FOCUS=$(dumpsys window windows | grep -E 'mCurrentFocus|mFocusedApp' | head -n 1)

    if echo "$CURRENT_FOCUS" | grep -q "$PACKAGE_NAME"; then
        if [ "$GAME_ACTIVE" = false ]; then
            echo "Free Fire Max detectado. Aplicando configuración de juego..."
            wm size "$TARGET_RESOLUTION"
            wm density "$TARGET_DENSITY"
            wm dpi "$TARGET_DENSITY" # Asumiendo que density y dpi son lo mismo aquí
            GAME_ACTIVE=true
        fi
    else
        if [ "$GAME_ACTIVE" = true ]; then
            echo "Free Fire Max cerrado. Restaurando configuración original..."
            wm size "$ORIGINAL_RESOLUTION"
            wm density "$ORIGINAL_DENSITY"
            wm dpi "$ORIGINAL_DENSITY" # Restaurando dpi a la densidad original
            GAME_ACTIVE=false
        fi
    fi
    sleep 5 # Esperar 5 segundos antes de volver a verificar
done
