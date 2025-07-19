FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Tokyo

RUN apt update && \
    apt install -y apache2 \
    gcc g++ make mariadb-server unixodbc unixodbc-dev \
    libmariadb-dev

RUN a2enmod cgi
COPY 000-default.conf /etc/apache2/sites-available/000-default.conf

# CGIソースコードとコンパイルスクリプトを一時的にコピー
COPY ./cgi-bin /tmp/cgi-bin
COPY compile_cgi.sh /tmp/compile_cgi.sh

# コンパイルスクリプトを実行してCGIプログラムを生成・配置
RUN chmod +x /tmp/compile_cgi.sh && /tmp/compile_cgi.sh

RUN chmod 755 /usr/lib/cgi-bin/
RUN find /usr/lib/cgi-bin/ -type f -exec chmod 755 {} \;

CMD ["apachectl","-D","FOREGROUND"]