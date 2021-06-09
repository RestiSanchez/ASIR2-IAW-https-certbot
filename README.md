# Práctica HTTPS con Let's Encrypt y Certbot

## Pasos a realizar

### Paso 1

**Crear instancia EC2** en AWS con los siguientes puertos:
- SSH (22/TCP)
- HTTP (80/TCP)
- HTTPS (443/TCP)
- 
### Paso 2
**Obtener la dirección IP** de la instancia EC2 en AWS.

### Paso 3
**Realizar la instalación y configuración de un sitio web**. Utilizamos los scripts que tenemos de las prácticas anteriores.

### Paso 4

**Registrar un nombre de dominio** en algún proveedor de dominio gratuito. En mi caso en NO-IP.

![IP CON DNS](imgs/ip.png)

**Configuramos los registros DNS del proveedor de nombres de dominio** para que el nombre del dominio que se ha registrado pueda resolver hacia la dirección pública de la instancia en AWS.

Como tenemos en el ejemplo de arriba.


### Paso 5

**Modificar el archivo de `https.sh` de alguna de las prácticas anteriores para incluir el servicio de Certbot**

```
#------------------ INSTALACIÓN Certbot ---------------------#

# Instala snapd y actualiza
snap install core; snap refresh core

# Eliminamos certbot-auto y cualquier paquete del sistema operativo Cerbot
apt-get remove certbot

# Instalamos Certbot
snap install --classic certbot 

# Ejecutamos el comando certbot
ln -s /snap/bin/certbot /usr/bin/certbot

# Automatizamos la renovación
certbot --apache -m demo@demo.es --agree-tos -d restisancheziaw.ddns.net
```



## Código del script
```
#!/bin/bash
set -x

# Actualizamos la lista de paquetes
apt update

# Actualizamos los paquetes
apt upgrade -y

#------------------ INSTALACIÓN Certbot ---------------------#

# Instala snapd y actualiza
snap install core; snap refresh core

# Eliminamos certbot-auto y cualquier paquete del sistema operativo Cerbot
apt-get remove certbot

# Instalamos Certbot
snap install --classic certbot 

# Ejecutamos el comando certbot
ln -s /snap/bin/certbot /usr/bin/certbot

# Automatizamos la renovación
certbot --apache -m demo@demo.es --agree-tos -d restisancheziaw.ddns.net

#------------------ INSTALACIÓN LAMP---------------------#

#Instalamos Apache2
apt install apache2 -y

# Instalamos el MySQL Server
apt install mysql-server -y

# Instalamos los módulos de PHP
apt install php libapache2-mod-php php-mysql -y

#------------------ INSTALACIÓN WORDPRESS CON WP-CLI ---------------------#

#Descargamos el archivo wp-cli.phar
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

#Asignamos permisos de ejecución
chmod +x wp-cli.phar

#Movemos el archivo al directorio /usr/local/bin
mv wp-cli.phar /usr/local/bin/wp

#VARIABLES
BD_NOMBRE=wpiaw
BD_USUARIO=resti
IP_FRONT=localhost
BD_PASS=root

#Nos situamos en el directorio donde vamos a realizar la instalación.
cd /var/www/html

#Descargamos el código fuente de Wordpress
wp core download --locale=es_ES --allow-root


# Configuración de base de datos

mysql -u root <<< "DROP DATABASE IF EXISTS $BD_NOMBRE;"
mysql -u root <<< "CREATE DATABASE $BD_NOMBRE;"
mysql -u root <<< "DROP USER IF EXISTS $BD_USUARIO@$IP_FRONT;"
mysql -u root <<< "CREATE USER $BD_USUARIO@$IP_FRONT IDENTIFIED BY '$BD_PASS';"
mysql -u root <<< "GRANT ALL PRIVILEGES ON $BD_NOMBRE.* TO $BD_USUARIO@$IP_FRONT;"
mysql -u root <<< "FLUSH PRIVILEGES;"

#Creamos el archivo de configuración
wp config create --dbname=$BD_NOMBRE --dbuser=$BD_USUARIO --dbpass=$BD_PASS --allow-root

#Instalamos Wordpress
wp core install --url=http://restisancheziaw.ddns.net --title="IAW" --admin_user=admin --admin_password=admin --admin_email=admin@admin.com --allow-root

#Eliminamos el index.html 
cd /var/www/html
rm -rf index.html

#Reiniciamos apache
systemctl restart apache2.service
```
