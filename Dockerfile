FROM ubuntu:18.04

# Adding sources and updating
#RUN echo "" > /etc/apt/sources.list \
#    && apt-get update


# Installing base software
RUN apt-get update \
	&& apt-get install -y curl apt-transport-https gnupg wget dpkg 

