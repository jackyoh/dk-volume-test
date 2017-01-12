#!/bin/bash
set -e

mkdir -p "$TOMCATWEBAPPS/ROOT"
echo "Hello World" > "$TOMCATWEBAPPS/ROOT/hello.html"
#grep -v rootfs /proc/mounts > /etc/mtab
#df -h > "$TOMCATWEBAPPS/ROOT/df.html"
/opt/apache-tomcat-7.0.73/bin/catalina.sh run -config /server.xml

#exec "$@"
