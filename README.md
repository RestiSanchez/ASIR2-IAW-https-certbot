# Práctica HTTPS con Let's Encrypt y Certbot

## Pasos a realizar

### Paso 1

**Crear instancia EC2** en AWS con los siguientes puertos:
- SSH (22/TCP)
- HTTP (80/TCP)
- HTTPS (443/TCP)
- 
### Paso 2
**Obtener la dirección IP** de la instancia EC2 en AWS

### Paso 3
**Realizar la instalación y configuración de un sitio web**. Utilizamos los scripts que tenemos de las prácticas anteriores

### Paso 4

**Registrar un nombre de dominio** en algún proveedor de dominio gratuito. En mi caso en NO-IP

### Pasos para no redirigir

1. Nos metemos a phpmyadmin
2. Vamos a SQL e introducimos:

```
UPDATE ps_configuration SET value = '1' WHERE name = 'PS_SSL_ENABLED';
UPDATE ps_configuration SET value = '1' WHERE name = 'PS_SSL_ENABLED_EVERYWHERE';
```
