FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Tokyo

RUN apt update && \
    apt install -y apache2 \
    gcc g++ make mariadb-server unixodbc unixodbc-dev \
    libmariadb-dev

RUN echo "AddHandler cgi-script .cgi" >> /etc/apache2/mods-available/cgi.conf
RUN echo "ScriptAlias /cgi-bin/ /usr/lib/cgi-bin/" >> /etc/apache2/mods-available/cgi.conf

COPY ./cgi-bin /usr/lib/cgi-bin/
RUN chmod +x /usr/lib/cgi-bin/*

CMD ["apachectl","-D","FOREGROUND"]