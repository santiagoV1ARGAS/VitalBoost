#!/bin/sh
set -e

# Railway inyecta la variable PORT en tiempo de ejecución; localmente,
# si no existe, usamos 8080 (el puerto por defecto de Tomcat).
PORT="${PORT:-8080}"

sed -i "s/port=\"8080\"/port=\"${PORT}\"/" /usr/local/tomcat/conf/server.xml

exec catalina.sh run
