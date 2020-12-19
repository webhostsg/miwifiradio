FROM richarvey/nginx-php-fpm
ARG MIR_WWW_PATH
ARG MIR_DOMAIN_NAME
ARG MIR_SSL_ENABLED
ENV MIR_WWW_PATH=/config/www/miwifiradio/
RUN apk update
RUN apk add ffmpeg
WORKDIR /config/www/miwifiradio/
ADD ./ ./
RUN mkdir -p uploads/playing
RUN chmod a+w uploads
RUN chmod a+w uploads/playing
RUN chmod a+w config/config.php
RUN envsubst '192.168.1.132/config/www/miwifiradio/' < docker/nginx.config > /etc/nginx/sites-enabled/default.conf
RUN if [ "$MIR_SSL_ENABLED" = "1" ] ; then envsubst '192.168.1.132/config/www/miwifiradio/' < docker/nginx.ssl.config > /etc/nginx/sites-enabled/default.ssl.conf ; fi;
RUN sed -i 's/libfdk_aac/aac/g' include/ffcontrol.php
#TODO: Add script ffkill.php to cron "*/5 * * * * /usr/local/bin/php /www/miradio/ffkill.php"
