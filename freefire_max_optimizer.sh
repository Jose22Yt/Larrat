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

# --- Funciones de Visualización ---
print_header() {
    echo ""
    echo "════════════════════════════════════════════════════════════════════════════════"
    echo "🚀✨ Free Fire Max Optimizer & Aimbot Mode Activator ✨🚀"
    echo "════════════════════════════════════════════════════════════════════════════════"
    echo ""
}

print_footer() {
    echo ""
    echo "════════════════════════════════════════════════════════════════════════════════"
    echo "✅ Optimización Finalizada. ¡A dominar el campo de batalla! ✅"
    echo "════════════════════════════════════════════════════════════════════════════════"
    echo ""
}

print_status() {
    echo "🎮 $1"
}

print_warning() {
    echo "⚠️ $1"
}

# --- Inicio del Script ---
print_header
print_status "Iniciando proceso de optimización para Free Fire Max..."

# 1. Optimización de la Tasa de Refresco (120Hz/FPS)
print_status "⚙️ Ajustando tasa de refresco para 120Hz/FPS..."
settings put system min_refresh_rate 0
settings put system peak_refresh_rate 0
print_status "✅ Tasa de refresco ajustada para máxima fluidez."

# 2. Modo Aimbot: Optimización de la Velocidad del Puntero y Sensibilidad Táctil
print_status "🎯 Activando Modo Aimbot: Ajustes de Sensibilidad Extrema..."
settings put system pointer_speed 7
settings put system touch_sensitivity 2
settings put secure long_press_timeout 250
settings put secure multi_press_timeout 250
print_status "✅ Velocidad del puntero y sensibilidad táctil calibradas para Headshots."

# 3. Optimización de las Escalas de Animación (Fluidez de la UI)
print_status "⚡ Optimizando animaciones del sistema para mayor agilidad..."
settings put global window_animation_scale 0.5
settings put global transition_animation_scale 0.5
settings put global animator_duration_scale 0.5
print_status "✅ Escalas de animación del sistema reducidas."

# 4. Otras Optimizaciones Generales
print_status "🧹 Realizando ajustes generales del sistema..."
settings put system show_touches 0
print_status "✅ Visualización de toques desactivada."

# --- Monitoreo en Tiempo Real para Resolución y DPI ---

print_status "👁️ Iniciando monitoreo en tiempo real para Free Fire Max..."

# Obtener la resolución y densidad originales
ORIGINAL_RESOLUTION=$(wm size | grep -oP "(?<=Physical size: )\S+" || wm size | grep -oP "(?<=Current size: )\S+")
ORIGINAL_DENSITY=$(wm density | grep -oP "(?<=Physical density: )\S+" || wm density | grep -oP "(?<=Current density: )\S+")

if [ -z "$ORIGINAL_RESOLUTION" ]; then
    ORIGINAL_RESOLUTION="$(wm size | awk \'{print $3}\')"
fi
if [ -z "$ORIGINAL_DENSITY" ]; then
    ORIGINAL_DENSITY="$(wm density | awk \'{print $3}\')"
fi

print_status "💾 Resolución original: $ORIGINAL_RESOLUTION, Densidad original: $ORIGINAL_DENSITY"
print_status "⏳ Esperando que Free Fire Max se inicie..."

GAME_ACTIVE=false

while true; do
    CURRENT_FOCUS=$(dumpsys window windows | grep -E 'mCurrentFocus|mFocusedApp' | head -n 1)

    if echo "$CURRENT_FOCUS" | grep -q "$PACKAGE_NAME"; then
        if [ "$GAME_ACTIVE" = false ]; then
            print_status "🔥 Free Fire Max detectado. Aplicando configuración de juego (Resolución: $TARGET_RESOLUTION, Densidad/DPI: $TARGET_DENSITY)..."
            wm size "$TARGET_RESOLUTION"
            wm density "$TARGET_DENSITY"
            wm dpi "$TARGET_DENSITY" # Asumiendo que density y dpi son lo mismo aquí
            GAME_ACTIVE=true
            print_status "✅ Configuración de juego aplicada con éxito."
        fi
    else
        if [ "$GAME_ACTIVE" = true ]; then
            print_status "❄️ Free Fire Max cerrado. Restaurando configuración original..."
            wm size "$ORIGINAL_RESOLUTION"
            wm density "$ORIGINAL_DENSITY"
            wm dpi "$ORIGINAL_DENSITY" # Restaurando dpi a la densidad original
            GAME_ACTIVE=false
            print_status "✅ Configuración original restaurada."
            print_status "💤 Monitoreo en pausa hasta el próximo inicio del juego..."
        fi
    fi
    sleep 5 # Esperar 5 segundos antes de volver a verificar
done

print_footer
