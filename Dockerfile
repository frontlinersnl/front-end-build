FROM node:16.10.0-buster

# install Chromium for (unit)-testing during build-phase
RUN apt-get update && \
  apt-get install -y --no-install-recommends 'chromium=90.0.4430.212-1~deb10u1' && \
  rm -rf /var/lib/apt/lists/*

# install Firefox for (unit)-testing during build-phase
RUN apt-get update && \
  apt-get install -y --no-install-recommends 'firefox-esr=78.14.0esr-1~deb10u1' && \
  rm -rf /var/lib/apt/lists/*

# install sonar-scanner
ENV SONAR_VERSION="4.6.2.2472-linux"
COPY sonar-scanner-cli-$SONAR_VERSION.zip /var/opt/
RUN unzip /var/opt/sonar-scanner-cli-$SONAR_VERSION.zip -d /var/opt && \
  rm /var/opt/sonar-scanner-cli-$SONAR_VERSION.zip
ENV PATH="$PATH:/var/opt/sonar-scanner-$SONAR_VERSION/bin"

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
