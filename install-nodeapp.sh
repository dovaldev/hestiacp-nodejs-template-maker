#!/bin/bash

# Verifica si se proporcionó un puerto como argumento
if [ "$#" -ne 1 ]; then
    echo "Uso: $0 <puerto>"
    exit 1
fi

PUERTO=$1
PREFIX="/usr/local/hestia/data/templates/web/nginx/nodejs${PUERTO}"

# Verifica si los archivos ya existen
for EXTENSION in sh tpl stpl; do
    if [ -f "${PREFIX}.${EXTENSION}" ]; then
        echo "El archivo ${PREFIX}.${EXTENSION} ya existe. Abortando."
        exit 1
    fi
done

# Crea los archivos
touch "${PREFIX}.sh"
touch "${PREFIX}.tpl"
touch "${PREFIX}.stpl"

# Establece los permisos
chmod 755 "${PREFIX}.sh"
chmod 755 "${PREFIX}.tpl"
chmod 755 "${PREFIX}.stpl"

# Añade contenido al archivo .sh
cat <<EOF > "${PREFIX}.sh"
#!/bin/bash
user=\$1
domain=\$2
ip=\$3
home=\$4
docroot=\$5

mkdir "\$home/\$user/web/\$domain/nodeapp"
chown -R \$user:\$user "\$home/\$user/web/\$domain/nodeapp"
rm "\$home/\$user/web/\$domain/nodeapp/app.sock"
runuser -l \$user -c "pm2 start \$home/\$user/web/\$domain/nodeapp/app.js"
sleep 5
chmod 777 "\$home/\$user/web/\$domain/nodeapp/app.sock"
EOF

# Añade contenido al archivo .tpl
cat <<EOF > "${PREFIX}.tpl"
server {
        listen %ip%:%proxy_port%;
        server_name %domain_idn% %alias_idn%;
        error_log /var/log/%web_system%/domains/%domain%.error.log error;

        location / {
                proxy_pass http://127.0.0.1:${PUERTO};
                proxy_http_version 1.1;
                proxy_set_header Upgrade \$http_upgrade;
                proxy_set_header Connection 'upgrade';
                proxy_set_header Host \$host;
                proxy_cache_bypass \$http_upgrade;
            }

        location /error/ {
                 alias %home%/%user%/web/%domain%/document_errors/;
        }

        location @fallback {
                 proxy_pass http://127.0.0.1:${PUERTO}:/\$1;
        }

        location ~ /\.ht {return 404;}
        location ~ /\.svn/ {return 404;}
        location ~ /\.git/ {return 404;}
        location ~ /\.hg/ {return 404;}
        location ~ /\.bzr/ {return 404;}
        include %home%/%user%/conf/web/nginx.%domain%.conf*;
}
EOF

# Añade contenido al archivo .stpl
cat <<EOF > "${PREFIX}.stpl"
server {
        listen %ip%:%proxy_port%;
        server_name %domain_idn% %alias_idn%;
        return 301 https://%domain_idn%\$request_uri;
}

server {
        listen %ip%:%proxy_ssl_port% http2 ssl;
        server_name %domain_idn% %alias_idn%;
        ssl_certificate %ssl_pem%;
        ssl_certificate_key %ssl_key%;
        error_log /var/log/%web_system%/domains/%domain%.error.log error;
        gzip on;
        gzip_min_length 1100;
        gzip_buffers 4 32k;
        gzip_types image/svg+xml svg svgz text/plain application/x-javascript text/xml text/css;
        gzip_vary on;

        location / {
                proxy_pass http://127.0.0.1:${PUERTO};
                proxy_http_version 1.1;
                proxy_set_header Upgrade \$http_upgrade;
                proxy_set_header Connection 'upgrade';
                proxy_set_header Host \$host;
                proxy_cache_bypass \$http_upgrade;
        }

        location /error/ {
                alias %home%/%user%/web/%domain%/document_errors/;
        }

        location @fallback {
                proxy_pass https://127.0.0.1:${PUERTO}:/\$1;
        }

        location ~ /\.ht {return 404;}
        location ~ /\.svn/ {return 404;}
        location ~ /\.git/ {return 404;}
        location ~ /\.hg/ {return 404;}
        location ~ /\.bzr/ {return 404;}
        include %home%/%user%/conf/web/%domain%/nginx.ssl.conf_*;
}
EOF

echo "Archivos de configuración para Node.js en el puerto ${PUERTO} creados."
