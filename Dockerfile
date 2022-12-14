FROM code-dal1.penguintech.group:5050/ptg/standards/docker-ansible-image:stable
LABEL company="Penguin Tech Group LLC"
LABEL org.opencontainers.image.authors="info@penguintech.group"
LABEL license="GNU AGPL3"

# GET THE FILES WHERE WE NEED THEM!
COPY . /opt/manager/
WORKDIR /opt/manager

# UPDATE as needed
RUN apt update && apt dist-upgrade -y && apt auto-remove -y && apt clean -y

# PUT YER ARGS in here
ARG APP_TITLE="HMDM"
ARG APP_LINK="https://github.com/h-mdm/hmdm-server/archive/refs/heads/master.zip"
ARG TOMCAT_LINK="https://dlcdn.apache.org/tomcat/tomcat-10/v10.0.27/bin/apache-tomcat-10.0.27.tar.gz"
ARG TOMCAT_VERSION="apache-tomcat-10.0.27"

# BUILD IT!
RUN ansible-playbook build.yml -c local

# PUT YER ENVS in here
ENV DATABASE_NAME="hmdm"
ENV DATABASE_USER="hmdm"
ENV DATABASE_PASSWORD="p@ssword"
ENV DATABASE_HOST="postgresql"
ENV DATABASE_PORT="5432"
ENV CPU_COUNT="2"
ENV FILE_LIMIT="1042"

EXPOSE 8080 8443 31000
# Switch to non-root user
USER ptg-user

# Entrypoint time (aka runtime)
ENTRYPOINT ["/bin/bash","/opt/manager/entrypoint.sh"]
