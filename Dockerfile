FROM ubuntu:18.04
ENV server="server" \
    fqdn="fqdn" \
    port="80" \
    haproxyadmin="haproxyadmin"
 
COPY haproxygen.py /haproxygen.py
COPY docker-entrypoint.sh /docker-entrypoint.sh 
COPY haproxy.cfg.j2 /haproxy.cfg.j2
RUN apt-get update && apt-get install haproxy openssl python-jinja2 -y
RUN mkdir -p /etc/certs && chown haproxy:haproxy -R /etc/certs/ && chmod a+x /docker-entrypoint.sh
CMD /docker-entrypoint.sh

