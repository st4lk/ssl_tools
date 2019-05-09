FROM python:3.6.8-stretch

RUN apt-get update -y && apt-get install -y xxd && apt-get install -y nginx

RUN mkdir -p /ssl_tools
RUN mkdir -p /opt/runtime/
RUN useradd -ms /bin/bash ssluser
RUN chown -R ssluser:ssluser /ssl_tools

WORKDIR /ssl_tools

CMD ["bash"]
