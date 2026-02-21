#!/system/bin/sh

# Ejecutado al inicio del sistema, antes de que se monten los datos.
# Aquí se aplican optimizaciones generales del sistema.

MODDIR=${0%/*}

log_print() {
  echo "FFMAX_OPTIMIZER: $1"
}

log_print "Aplicando optimizaciones generales del sistema..."

# 1. Desactivar todas las animaciones del sistema (0)
log_print "⚙️ Desactivando animaciones del sistema (0)..."
settings put global window_animation_scale 0
settings put global transition_animation_scale 0
settings put global animator_duration_scale 0
log_print "✅ Animaciones del sistema desactivadas."

# 2. Optimización de la Tasa de Refresco (120Hz/FPS)
log_print "⚙️ Ajustando tasa de refresco para 120Hz/FPS..."
settings put system min_refresh_rate 0
settings put system peak_refresh_rate 0
log_print "✅ Tasa de refresco ajustada para máxima fluidez."

# 3. Optimización de la Velocidad del Puntero y Sensibilidad Táctil (Modo Aimbot)
log_print "🎯 Ajustando velocidad del puntero y sensibilidad táctil..."
settings put system pointer_speed 7
settings put system touch_sensitivity 2
settings put secure long_press_timeout 250
settings put secure multi_press_timeout 250
log_print "✅ Velocidad del puntero y sensibilidad táctil calibradas."

# 4. Otras Optimizaciones Generales
log_print "🧹 Realizando ajustes generales del sistema..."
settings put system show_touches 0
log_print "✅ Visualización de toques desactivada."

# 5. Optimizaciones específicas para Xiaomi (MIUI/HyperOS) - EXPERIMENTAL
# Estos comandos pueden variar y deben usarse con precaución.
# Pueden mejorar la respuesta táctil y el rendimiento de la GPU.

# Descomentar y probar si se tiene un dispositivo Xiaomi y se desea experimentar.
# log_print "🚀 Aplicando optimizaciones específicas para Xiaomi..."
# settings put system touch_response_mode 1 # Mejora la respuesta táctil
# settings put system touch_hover_mode 1 # Mejora la precisión del toque
# settings put system game_mode_enable 1 # Activa el modo juego (si existe)
# settings put global sem_enhanced_cpu_responsiveness 1 # Prioriza la CPU
# settings put global sem_low_heat_mode 0 # Desactiva el modo de baja temperatura para rendimiento
# log_print "✅ Optimizaciones Xiaomi aplicadas."

log_print "Optimizaciones generales del sistema aplicadas con éxito."
