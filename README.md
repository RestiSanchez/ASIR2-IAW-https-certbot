

### Pasos para no redirigir

1. Nos metemos a phpmyadmin
2. Vamos a SQL e introducimos:

```
UPDATE ps_configuration SET value = '1' WHERE name = 'PS_SSL_ENABLED';
UPDATE ps_configuration SET value = '1' WHERE name = 'PS_SSL_ENABLED_EVERYWHERE';
```
