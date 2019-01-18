server {
  listen 80 default_server;
  listen [::]:80 default_server;
  listen 8080 default_server;
  listen [::]:8080 default_server;

  listen 443 ssl default_server;
  listen [::]:443 ssl default_server;
  listen 4443 ssl default_server;
  listen [::]:4443 ssl default_server;

  root /var/www/tuan.com;

  server_name tuan.com www.tuan.com;
  ssl_certificate /etc/nginx/ssl/nginx.crt;
  ssl_certificate_key /etc/nginx/ssl/nginx.key;

  location = / {
    index index.html;
  }

  location /forum {
    autoindex on;
  }

  location /admin {
    auth_basic           "Administrator’s area";
    auth_basic_user_file /etc/nginx/.htpasswd;
  }
}
