ARG GARFANA_VERSION=6.3.6

FROM grafana/grafana:${GARFANA_VERSION}

USER root
RUN apt-get update && apt-get install -y \
        awscli \
    && rm -rf /var/lib/apt/lists/*

COPY aws-decrypt.sh /aws-decrypt.sh
RUN chmod u+x /aws-decrypt.sh && chown grafana:grafana /aws-decrypt.sh

USER grafana
ENTRYPOINT [ "/aws-decrypt.sh" ]