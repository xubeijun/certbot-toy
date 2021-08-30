######
# https://hub.docker.com/r/certbot/certbot
######

FROM certbot/certbot:latest
ARG APP_DIR
MAINTAINER xubeijun

RUN apk add --no-cache --upgrade bash && rm -rf /var/cache/apk/*

RUN sed -i -e "s/bin\/ash/bin\/bash/" /etc/passwd

WORKDIR ${APP_DIR}
COPY ./scripts/docker/ .

RUN chmod +x ${APP_DIR}hooks/* ${APP_DIR}docs/* index.sh

RUN ln -s ${APP_DIR}/index.sh /usr/local/bin/certbot-toy

ENTRYPOINT ["/bin/bash"]