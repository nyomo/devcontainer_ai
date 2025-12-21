FROM debian:trixie

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update

RUN apt-get install -y --no-install-recommends \
    locales \
    ca-certificates 
RUN apt-get update
RUN apt-get install -y --no-install-recommends \ 
    sudo \ 
    git \
    curl

RUN echo "ja_JP.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen ja_JP.UTF-8 && \
    dpkg-reconfigure locales && \
    /usr/sbin/update-locale LANG=ja_JP.UTF-8
ENV LANG=ja_JP.UTF-8
ENV LANGUAGE=ja_JP:ja
ENV LC_ALL=ja_JP.UTF-8

# macOSの標準のグループに合わせる
RUN groupmod -n macusers dialout && \
    groupadd -g 1100 appgroup && useradd -u 502 -G appgroup -s /bin/bash -N -M appuser && \
    usermod -aG macusers root && \
    usermod -aG macusers appuser
RUN mkdir /home/appuser && \
    chown -R appuser:appgroup /home/appuser && \
    echo "%appgroup ALL=(ALL:ALL) NOPASSWD: ALL" > /etc/sudoers.d/appgroup && \
    mkdir /workdir 

USER appuser

