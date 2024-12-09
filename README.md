Proyecto de Configuración de BIND9 con Docker
Este repositorio proporciona una configuración completa para ejecutar un servidor DNS utilizando BIND9 en un contenedor Docker. Está diseñado para el dominio luisvir.com y soporta actualizaciones dinámicas de DNS mediante claves TSIG.

Estructura del Repositorio
bind9.yml: Archivo Docker Compose para iniciar el contenedor BIND9.
luisvir.com.db: Archivo de zona DNS para el dominio.
named.conf.local: Archivo de configuración de BIND9 con claves TSIG y definición de la zona.
named.conf.options: Archivo de configuración general de BIND9.
ipdinamica.sh: Script para actualizar automáticamente la dirección IP en la zona DNS.
Requisitos
Docker y Docker Compose instalados.
Un dominio registrado (ej: luisvir.com).
Instrucciones de Uso
Clonar el repositorio:
Bash
git clone https://github.com/tu_usuario/mi_repositorio.git
cd mi_repositorio
Usa el código con precaución.

Configurar:
Ajustar los archivos de configuración según tus necesidades.
Personalizar el dominio en luisvir.com.db y otros archivos.
Iniciar el contenedor:
Bash
docker-compose -f bind9.yml up -d
Usa el código con precaución.

Verificar:
Bash
docker ps
Usa el código con precaución.

Configurar actualizaciones dinámicas (opcional):
Ejecutar ipdinamica.sh manualmente o programarlo en un cron.
Permisos: chmod +x ipdinamica.sh
Personalización
Zona DNS: Modificar los registros en luisvir.com.db.
IP Dinámica: El script ipdinamica.sh se encarga de actualizar la IP.
Claves TSIG: Asegurar su correcta generación y uso.
Notas
El contenedor se reinicia automáticamente.
La propagación de cambios puede tardar.
Revisar los logs de BIND para solucionar problemas:
Bash
sudo docker logs -f bind9-container
