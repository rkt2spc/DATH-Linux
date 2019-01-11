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

# Disable default site
RUN rm /etc/nginx/sites-enabled/default

# Configure & Enable tuan.com site
COPY www/tuan.com /var/www/tuan.com
RUN chown -R root:webadmin /var/www
RUN chmod -R 775 /var/www
COPY conf/nginx/tuan.com /etc/nginx/sites-available
RUN ln -s /etc/nginx/sites-available/tuan.com /etc/nginx/sites-enabled/tuan.com

# Forward request and error logs to stdout and stderr
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
	&& ln -sf /dev/stderr /var/log/nginx/error.log

# Generate .htpasswd file for basic auth
RUN htpasswd -c -b /etc/nginx/.htpasswd ${ADMIN_USERNAME} ${ADMIN_PASSWORD}

#################################################################################
#                                   SSHD                                        #
#################################################################################

# Copy configurations
COPY conf/ssh/sshd_config /etc/ssh/sshd_config

# Setup run directory
RUN mkdir -p /run/sshd

#################################################################################
#                                Supervisor                                     #
#################################################################################

# Copy configurations
COPY conf/supervisor/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Command
CMD ["/usr/bin/supervisord"]
