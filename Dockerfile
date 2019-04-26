FROM python:3.6.8-stretch

RUN apt-get update -y && apt-get install -y xxd

RUN mkdir -p /ssl_tools
RUN mkdir -p /opt/runtime/
RUN useradd -ms /bin/bash ssluser
RUN chown -R ssluser:ssluser /ssl_tools

USER ssluser

CMD bash
