FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Tokyo

RUN apt update && \
    apt install -y apache2 \
    gcc g++ make mariadb-server unixodbc unixodbc-dev \
    libmariadb-dev

RUN a2enmod cgi
COPY 000-default.conf /etc/apache2/sites-available/000-default.conf

COPY ./cgi-bin /tmp/cgi-bin
RUN gcc /tmp/cgi-bin/hello.c -o /usr/lib/cgi-bin/hello.cgi
RUN chmod +x /usr/lib/cgi-bin/hello.cgi

RUN chmod 755 /usr/lib/cgi-bin/
RUN find /usr/lib/cgi-bin/ -type f -exec chmod 755 {} \;

CMD ["apachectl","-D","FOREGROUND"]