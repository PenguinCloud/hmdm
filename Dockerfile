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
ARG APP_LINK="https://h-mdm.com/files/hmdm-5.12.1-os.war"
ARG APP_VERSION="hmdm-5.12.1-os"
ARG TOMCAT_LINK="https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.40/bin/apache-tomcat-9.0.40.tar.gz"
ARG TOMCAT_VERSION="apache-tomcat-9.0.40"
ARG PAGER_APK_LINK="https://h-mdm.com/files/pager-1.01.apk"
ARG PHONE_PROXY_LINK="https://h-mdm.com/files/phoneproxy-1.02.apk"
ARG LAUNCHER_RESTARTER_LINK="https://h-mdm.com/files/LauncherRestarter-1.04.apk"

# BUILD IT!
RUN ansible-playbook build.yml -c local

# PUT YER ENVS in here
ENV DATABASE_NAME="hmdm"
ENV DATABASE_USER="hmdm"
ENV DATABASE_PASSWORD="P@ssWord"
ENV DATABASE_HOST="database"
ENV DATABASE_PORT="5432"
ENV ADMIN_EMAIL="admin@example.com"
ENV APP_VERSION="hmdm-5.12.1"
ENV URL="localhost"
ENV PROTOCOL="http"

EXPOSE 8080 31000
# Switch to non-root user
# USER tomcat

# Entrypoint time (aka runtime)
ENTRYPOINT ["/bin/bash","/opt/manager/entrypoint.sh"]
