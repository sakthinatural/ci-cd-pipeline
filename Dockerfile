FROM ubuntu
ENV TZ=Europe/Kiev
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get update
RUN apt-get -y install apache2
RUN apt-get install tree
ADD . /var/www/html
ENTRYPOINT apachectl -D FOREGROUND
EXPOSE 80
