FROM grafana/grafana-oss:8.3.3

WORKDIR /grafana

EXPOSE 3000
#ENV GF_SERVER_DOMAIN=${GRAFANA_HOST}
#ENV GF_SERVER_ROOT_URL=http://${GRAFANA_HOST}/grafana
#ENV GF_SERVE_FROM_SUB_PATH=true
#ENV GF_PLUGIN_DIR=/plugins
#ENV GF_PATHS_PLUGINS=/plugins
ENV PROMETHEUS_HOST=localhost
ENV PROMETHEUS_PORT=9090
ENV GF_SECURITY_ADMIN_PASSWORD=foobar
ENV GF_USERS_ALLOW_SIGN_UP=false
ENV LOKI_HOST=localhost
ENV LOKI_PORT=3100

USER root

RUN apk update && \
    apk add curl

#ADD --chown=daemon:daemon config/datasources.yml /etc/grafana/provisioning/datasources/datasources.yaml
#ADD --chown=daemon:daemon config/dashboards /dashboards
#ADD --chown=daemon:daemon config/plugins /plugins
ADD --chown=daemon:daemon provisioning/ /etc/grafana/provisioning/
ADD --chown=daemon:daemon config/ /etc/grafana/config/

USER daemon