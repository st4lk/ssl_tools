FROM python:3.9-bullseye

RUN apt-get update -y && apt-get install -y xxd && apt-get install -y nginx

RUN mkdir -p /ssl_tools
RUN useradd -ms /bin/bash ssluser
RUN chown -R ssluser:ssluser /ssl_tools

WORKDIR /ssl_tools

CMD ["bash"]
