#! /bin/bash
apt update
apt -y install nginx 
cat <<EOF > /var/www/html/index.html
<html>
    <body>
        <h1> Hola desde un servidor nginx creado desde Terraform! </h1>
    </body>
</html>