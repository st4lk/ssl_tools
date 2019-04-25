FROM python:3.6.8-stretch

RUN mkdir -p /ssl_tools
RUN mkdir -p /opt/runtime/
RUN useradd -ms /bin/bash ssluser
RUN chown -R ssluser:ssluser /ssl_tools

USER ssluser

CMD bash
