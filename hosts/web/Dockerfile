FROM ubuntu:18.04

# Install dependencies
RUN apt-get update && apt-get install --yes \
  supervisor \
  openssh-server \
  apache2-utils \
  nginx

#################################################################################
#                                   Base                                        #
#################################################################################

# Create admin user
ARG ADMIN_USERNAME=tuan
ARG ADMIN_PASSWORD=123456
RUN groupadd webadmin
RUN useradd --create-home --groups webadmin ${ADMIN_USERNAME}
RUN echo "${ADMIN_USERNAME}:${ADMIN_PASSWORD}" | chpasswd

#################################################################################
#                                   NGINX                                       #
#################################################################################

# Copy nginx SSL cert and key
COPY ./etc/nginx/ssl /etc/nginx/ssl

# Copy nginx config
COPY ./etc/nginx/nginx.conf /etc/nginx/nginx.conf

# Remove symlink to disable the nginx default site
RUN rm /etc/nginx/sites-enabled/default

# Configure & Symlink to enable tuan.com site
COPY ./var/www/tuan.com /var/www/tuan.com
COPY ./etc/nginx/sites-available/tuan.com /etc/nginx/sites-available/tuan.com
RUN ln -s /etc/nginx/sites-available/tuan.com /etc/nginx/sites-enabled/tuan.com

# Ensure webadmin can update www contents
RUN chmod -R 755 /var/www
RUN chmod -R 775 /var/www/*
RUN chown -R root:webadmin /var/www

# Generate .htpasswd file for basic auth
RUN htpasswd -c -b /etc/nginx/.htpasswd ${ADMIN_USERNAME} ${ADMIN_PASSWORD}

#################################################################################
#                                   SSHD                                        #
#################################################################################

# Copy configurations
COPY ./etc/ssh/sshd_config /etc/ssh/sshd_config

# Setup sshd privilege separation directory
RUN mkdir -p /run/sshd

#################################################################################
#                                Supervisor                                     #
#################################################################################

# Copy configurations
COPY ./etc/supervisor/supervisord.conf /etc/supervisor/supervisord.conf

# Workdir
WORKDIR /workdir
COPY ./up.sh .

# Entrypoint
ENTRYPOINT ["/workdir/up.sh"]

# Command
CMD ["supervisord", "-c", "/etc/supervisor/supervisord.conf"]
