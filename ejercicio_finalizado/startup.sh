#! /bin/bash
apt update
apt -y install nginx 
cat <<EOF > /var/www/html/index.html
<html>
    <body>
        <h1> Saludos camarada, este es un servidor nginx creado con Terraform &#128513; </h1>
    </body>
</html>