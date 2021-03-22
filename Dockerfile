FROM node:14.16.0-alpine3.10
LABEL maintainer="Naologic <contact@naologic.com>"
LABEL org.label-schema.name="BOB"
LABEL org.label-schema.description="BOB data container"
LABEL org.label-schema.vendor="naologic.com"
LABEL org.label-schema.url="naologic.com"
LABEL org.label-schema.version="v4.0.0"

# Make the dir
RUN mkdir -p /var/nao
RUN mkdir -p /etc/pm2-web
WORKDIR /var/nao

RUN apt update && \
  apt install -y nano libgtk2.0-0 libgtk-3-0 libnotify-dev \
  libgconf-2-4 libnss3 libxss1 \
  libasound2 libxtst6 xauth musl musl-dev xvfb \
  libgbm-dev

# OLDER
RUN apt update \
    && apt install -y wget gnupg \
    && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
    && apt update \
    && apt install -y google-chrome-stable fonts-ipafont-gothic fonts-wqy-zenhei fonts-thai-tlwg fonts-kacst fonts-freefont-ttf libxss1 \
      --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*


ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true

# Install app dependencies
ENV NPM_CONFIG_LOGLEVEL warn
RUN npm install -g pm2
RUN npm install -g @nestjs/cli

USER $USER_ID

