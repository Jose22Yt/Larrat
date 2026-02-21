#!/system/bin/sh
# Script de Optimización Avanzada para Free Fire Max (Brevent Console)
# Creado por Manus AI

# Este script aplica varias configuraciones del sistema Android a través de comandos ADB
# para mejorar el rendimiento, la fluidez y la sensibilidad en Free Fire Max.
# Se recomienda ejecutar este script a través de la consola de Brevent.

# --- ADVERTENCIA ---
# Algunas configuraciones pueden variar en su efecto o compatibilidad dependiendo del modelo de tu dispositivo Android y la versión del sistema operativo.
# Si experimentas algún comportamiento inesperado, puedes reiniciar tu dispositivo para revertir la mayoría de los cambios.
# Utiliza este script bajo tu propia responsabilidad.

echo "Iniciando optimización para Free Fire Max..."

# 1. Optimización de la Tasa de Refresco (120Hz/FPS)
# Estos comandos intentan forzar la tasa de refresco más alta disponible en el dispositivo.
# Un valor de '0' generalmente indica que el sistema debe usar la tasa máxima.
settings put system min_refresh_rate 0
settings put system peak_refresh_rate 0
echo "Tasa de refresco ajustada para máxima fluidez."

# 2. Optimización de la Velocidad del Puntero y Sensibilidad Táctil
# Aumenta la velocidad del puntero para una respuesta más rápida.
# El valor máximo suele ser 7, pero puede variar. Ajusta si es necesario.
settings put system pointer_speed 7

# Ajusta la sensibilidad táctil. El valor '2' es a menudo un ajuste más alto.
# La efectividad de este comando puede variar significativamente entre dispositivos.
settings put system touch_sensitivity 2

# Reduce el tiempo de retardo para la pulsación larga y múltiple, mejorando la reactividad.
settings put secure long_press_timeout 250
settings put secure multi_press_timeout 250
echo "Velocidad del puntero y sensibilidad táctil ajustadas."

# 3. Optimización de las Escalas de Animación (Fluidez de la UI)
# Reduce las escalas de animación para que la interfaz de usuario se sienta más rápida y fluida.
# Un valor de '0.5' es un buen equilibrio; '0' las desactiva completamente.
settings put global window_animation_scale 0.5
settings put global transition_animation_scale 0.5
settings put global animator_duration_scale 0.5
echo "Escalas de animación del sistema reducidas para mayor agilidad."

# 4. Otras Optimizaciones Generales
# Desactiva la visualización de toques en pantalla. Puede ofrecer una mejora mínima en el rendimiento.
settings put system show_touches 0
echo "Visualización de toques desactivada."

# 5. Configuración de Rendimiento Específica (Experimental)
# Algunos dispositivos pueden beneficiarse de estas configuraciones para priorizar el rendimiento.
# La disponibilidad y el efecto de estos comandos pueden variar.
# settings put global sem_enhanced_cpu_responsiveness 1 # Descomentar si tu dispositivo lo soporta y deseas probar.
# settings put global sem_low_heat_mode 0 # Descomentar si tu dispositivo lo soporta y deseas probar (0 para rendimiento, 1 para baja temperatura).

echo "Optimización completada. ¡Disfruta de Free Fire Max!"
