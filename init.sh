#!/bin/sh
#Script de Init - Matheus Bona
#mateus.bona@gmail.com
#Se der pau não me chama :D

echo "Carregando o PHP em /www/public"

echo "Copiando arquivos de rota = Mod Rewrite"
cp /.htrouter.php /www/public/.htrouter.php

echo "Executando composer..."
cd /www && composer update;

echo "Carregando servidor em 0.0.0.0:8080"

php -S 0.0.0.0:8080 -t /www/public /www/public/.htrouter.php
