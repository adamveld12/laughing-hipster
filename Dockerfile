FROM archlinux:latest

ENV FILES_DEBUG true

RUN pacman -Sy --noconfirm openssh sudo vim git which gnupg make gcc binutils bison \
	&& echo '%sudo ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers \
	&& groupadd sudo \
	&& useradd -m -u 1000 -G sudo files \
	&& echo "files:files" | chpasswd files


WORKDIR /home/files
COPY --chown=1000:1000 . /home/files/.files
USER 1000
RUN rm -rf .bash_rc .bash_logout .zshrc \
	&& source /home/files/.files/sourceme.sh \
	&& echo "source /home/files/.files/sourceme.sh" > /home/files/.bash_profile

CMD ["bash", "--login"]
