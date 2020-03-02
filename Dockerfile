FROM debian:bullseye

ARG version=dev
ARG commit=dev
ARG created=never

LABEL maintainer="Adam Veldhousen <adam@veldhousen.net>"
LABEL net.veldhousen.version=${version}
LABEL net.veldhousen.commit=${commit}
LABEL net.veldhousen.created=${created}

RUN apt-get update -qq && apt-get install -qq -y sudo apt-utils && apt-get clean
RUN useradd  -G sudo -U -u 1000 -m -s /bin/bash dev \
    && echo 'dev:dev' | chpasswd \
    && mkdir -p /home/dev/Projects \
    && rm -rf /home/dev/.bashrc \
    && chown -R dev:dev /home/dev/ \
    && echo "dev ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/dev_no_pass

USER 1000

WORKDIR /home/dev
COPY . /home/dev/Projects/dotfiles
RUN /home/dev/Projects/dotfiles/install dev \
    && sudo rm -rf /tmp/*

ENTRYPOINT ["/bin/bash", "--login"]


