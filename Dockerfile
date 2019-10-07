FROM debian:bullseye

RUN apt-get update && apt-get install -y sudo apt-utils && apt-get clean
RUN useradd  -G sudo -U -u 1000 -m -s /bin/bash dev \
    && echo 'dev:dev' | chpasswd \
    && mkdir -p /home/dev/Projects \
    && chown -R dev:dev /home/dev/ \
    && echo "dev ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/dev_no_pass


USER 1000

WORKDIR /home/dev
COPY . /home/dev/Projects/dotfiles
RUN rm -rf /home/dev/.bashrc \ 
    && /home/dev/Projects/dotfiles/install dev \
    && sudo rm -rf /tmp/*

ENTRYPOINT ["/bin/bash", "--login"]


