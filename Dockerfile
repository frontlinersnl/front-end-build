FROM node:19.7-buster

# install Chromium for (unit)-testing during build-phase
RUN apt-get update && \
  apt-get install -y --no-install-recommends libgtk2.0-0 libgtk-3-0 libgbm-dev libnotify-dev libgconf-2-4 libnss3 libxss1 libasound2 libxtst6 xauth xvfb && \
  apt-get install -y --no-install-recommends 'chromium=90.0.4430.212-1~deb10u1' && \
  rm -rf /var/lib/apt/lists/*

# install Firefox for (unit)-testing during build-phase
RUN apt-get update && \
  apt-get install -y --no-install-recommends 'firefox-esr=91.12.0esr-1~deb10u1' && \
  rm -rf /var/lib/apt/lists/*

# install sonar-scanner
ENV SONAR_VERSION="4.6.2.2472-linux"
COPY sonar-scanner-cli-$SONAR_VERSION.zip /var/opt/
RUN unzip /var/opt/sonar-scanner-cli-$SONAR_VERSION.zip -d /var/opt && \
  rm /var/opt/sonar-scanner-cli-$SONAR_VERSION.zip
ENV PATH="$PATH:/var/opt/sonar-scanner-$SONAR_VERSION/bin"

# install docker-compose
RUN apt-get update && \
  apt-get install -y --no-install-recommends ca-certificates docker-compose gnupg2 pass && \
  rm -rf /var/lib/apt/lists/*

# install testrail-cli
RUN apt-get update && \
  apt-get install -y --no-install-recommends python3-pip && \
  apt-get install python3-setuptools && \
  pip3 install trcli && \
  rm -rf /var/lib/apt/lists/*

# copy build scripts into container
RUN mkdir /code
WORKDIR /code
COPY entrypoint.sh /entrypoint.sh
COPY front-end-build.sh /front-end-build.sh

# set execute on the scripts
RUN chmod +x /entrypoint.sh && \
  chmod +x /front-end-build.sh

# start the build
CMD [ "bash", "/entrypoint.sh" ]
