FROM debian:trixie

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update

RUN apt-get install -y --no-install-recommends \
    locales \
    ca-certificates 
RUN apt-get update
RUN apt-get install -y --no-install-recommends \ 
    sudo \ 
    gpg \
    git \
    curl \
    python3.13-venv

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

# install node.js v24
# https://deb.nodesource.com/setup_24.x
COPY ./nodesource-repo.gpg.key /tmp
RUN mkdir -p /usr/share/keyrings && \
    rm -f /usr/share/keyrings/nodesource.gpg && \
    rm -f /etc/apt/sources.list.d/nodesource.list && \
    cat /tmp/nodesource-repo.gpg.key | gpg --dearmor -o /usr/share/keyrings/nodesource.gpg && \
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/nodesource.gpg] https://deb.nodesource.com/node_24.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list > /dev/null && \
    apt update -y && \
    apt-get install -y --no-install-recommends nodejs 
RUN mkdir -p /opt/node_modules && \
    chown -R appuser:appgroup /opt/node_modules

USER appuser


# node.js
ENV PATH=/opt/node_modules/bin:${PATH}
RUN npm config set prefix "/opt/node_modules"
RUN npm install -g @openai/codex@latest
RUN ln -s /workdir/.codex /home/appuser/

# Python
RUN mkdir /home/appuser/python3 && \
    python3 -m venv /home/appuser/python3
#COPY ../requirements.txt /home/appuser
#RUN /home/appuser/python3/bin/pip install -r /home/appuser/requirements.txt
ENV PATH=/home/appuser/python3/bin:${PATH}
