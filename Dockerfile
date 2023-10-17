FROM registry.access.redhat.com/ubi8/ubi:8.0

MAINTAINER Red Hat Training <training@redhat.com>

# DocumentRoot for Apache
ENV DOCROOT=/var/www/html 


RUN   yum install -y --nodocs --disableplugin=subscription-manager httpd && \
yum clean all --disableplugin=subscription-manager -y && \
echo "Hello from the httpd container!" > ${DOCROOT}/index.html

# Allows child images to inject their own content into DocumentRoot
ONBUILD COPY src/ ${DOCROOT}/



# This stuff is needed to ensure a clean start
RUN rm -rf /run/httpd && mkdir /run/httpd
RUN chgrp -R 0 /var/run/httpd /var/log/httpd && chmod -R g=u /var/run/httpd /var/log/httpd

# Run as the root user


# Launch httpd
CMD /usr/sbin/httpd -DFOREGROUND
