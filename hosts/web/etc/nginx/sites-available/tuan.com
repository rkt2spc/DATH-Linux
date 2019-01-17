server {
  listen 80 default_server;
  listen [::]:80 default_server;
  listen 8080 default_server;
  listen [::]:8080 default_server;

  root /var/www/tuan.com;

  server_name tuan.com www.tuan.com;

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
