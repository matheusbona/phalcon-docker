FROM alpine:edge

MAINTAINER mateus.bona@gmail.com

RUN apk update && apk add --no-cache php5 php5-mcrypt php5-mysql php5-gd php5-xml php5-pdo php5-soap php5-curl php5-json php5-dev php5-phar php5-openssl php5-zlib php5-pear php5-pdo php5-pdo_mysql curl git gcc make pcre-dev autoconf g++ libc-dev bash

WORKDIR /
COPY init.sh /
COPY .htrouter.php /
RUN chmod +x init.sh && mkdir www && mkdir www/public && touch /www/public/index.php && echo "<?php phpinfo(); ?>" >> /www/public/index.php
RUN ln -s /usr/bin/php5 /bin/php && ln -s /usr/bin/php-config5 /bin/php-config && ln -s /usr/bin/phpize5 /bin/phpize
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/bin --filename=composer
RUN git clone -b 1.3.4 https://github.com/phalcon/cphalcon.git

WORKDIR /cphalcon/build
RUN /bin/bash install

WORKDIR /etc/php5/conf.d
RUN touch phalcon.ini && echo "extension=phalcon.so" >> phalcon.ini

WORKDIR /etc/php5
RUN sed -i 's/short_open_tag = Off/short_open_tag = On/g' php.ini && sed -i 's/asp_tags = Off/asp_tags = On/g' php.ini

EXPOSE 8080

WORKDIR /
ENTRYPOINT /bin/bash init.sh
