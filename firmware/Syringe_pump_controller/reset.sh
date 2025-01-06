#!/bin/bash

# Configuración
HORA_REVISION="14:00"  # Hora específica para revisar la conexión (formato 24 horas)
LOG_PATH="/ruta/al/archivo_log.txt"  # Ruta donde se guardará el log

# Función para comprobar conexión a Internet
revisar_conexion() {
    if ping -c 1 google.com &> /dev/null; then
        echo "$(date '+%Y-%m-%d %H:%M:%S') - Conexión OK"
    else
        echo "$(date '+%Y-%m-%d %H:%M:%S') - Sin conexión, reiniciando..." | tee -a "$LOG_PATH"
        sudo reboot
    fi
}

# Bucle principal para ejecutar la revisión a la hora especificada
while true; do
    # Obtiene la hora actual
    HORA_ACTUAL=$(date '+%H:%M')

    # Comprueba si es la hora especificada para la revisión
    if [ "$HORA_ACTUAL" == "$HORA_REVISION" ]; then
        revisar_conexion
        sleep 60  # Espera un minuto para evitar reinicios múltiples en la misma hora
    fi

    sleep 10  # Espera 10 segundos antes de volver a comprobar la hora actual
done

Permisos
chmod +x verificar_internet.sh


Ejecutarlo
nohup ./verificar_internet.sh &

Opcional: Para que el script se ejecute automáticamente al iniciar el sistema, puedes añadirlo al archivo rc.local o crear un servicio en systemd.
