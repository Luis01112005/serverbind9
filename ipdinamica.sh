#!/bin/bash

# Detener el proceso 'named' que se ejecuta en modo foreground
echo "Deteniendo el proceso named..."
pkill -f "/usr/sbin/named -g"
if [ $? -eq 0 ]; then
    echo "Proceso named detenido correctamente."
else
    echo "No se encontró el proceso named, continuando..."
fi

# Obtener la IP pública
IP=$(wget -qO- http://ifconfig.me/ip)

# Generar un nuevo archivo de zona con la IP pública
echo "Generando archivo de zona con la IP pública: $IP..."
cat <<EOF > /var/cache/bind/zones/luisvir.com.db
\$ORIGIN luisvir.com.  ; Establece el dominio base para los registros.

\$TTL 86400  ; Tiempo de vida (TTL) por defecto para los registros (1 día).

@   IN  SOA ns1.luisvir.com. admin.luisvir.com. (  ; Define el registro SOA para el dominio.
        2023120501  ; Número de serie (incrementar tras cambios).
        3600        ; Refresh: Tiempo para que los secundarios consulten actualizaciones (1 hora).
        1800        ; Retry: Reintento en caso de fallo (30 minutos).
        1209600     ; Expire: Tiempo máximo para mantener los datos sin actualizar (2 semanas).
        86400       ; TTL mínimo para los registros (1 día).
    )
    IN  NS  ns1.luisvir.com.  ; Define el servidor de nombres principal.
    IN  NS  ns2.luisvir.com.  ; Define el servidor de nombres secundario.

ns1 IN  A   $IP  ; Dirección IP del servidor de nombres principal.
ns2 IN  A   1.1.1.1  ; Dirección IP del servidor de nombres secundario.

@   IN  A   $IP  ; Dirección IP principal del dominio.
EOF

# Reiniciar el proceso 'named'
echo "Reiniciando el proceso named..."
/usr/sbin/named -g &
if [ $? -eq 0 ]; then
    echo "Proceso named reiniciado con éxito."
else
    echo "Error al reiniciar el proceso named."
    exit 1
fi
