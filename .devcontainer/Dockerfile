FROM debian:trixie

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update

RUN apt-get install -y --no-install-recommends \
    locales \
    ca-certificates
RUN apt-get update
RUN apt-get install -y --no-install-recommends git

RUN echo "ja_JP.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen ja_JP.UTF-8 && \
    dpkg-reconfigure locales && \
    /usr/sbin/update-locale LANG=ja_JP.UTF-8
ENV LANG=ja_JP.UTF-8
ENV LANGUAGE=ja_JP:ja
ENV LC_ALL=ja_JP.UTF-8