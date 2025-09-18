FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

#Install SSH, Python 3.10, sudo, and monitoring tools
SHELL["/bin/bash", "-o", "pipefall", "-c"]
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        openssh-server=1:8.9p1-3ubuntu0.10 \
    sudo=1.9.9-1ubuntu2.4 \
	curl=7.81.0-1ubuntu1.16 \
	ca-certificates=20230311ubuntu0.22.04.1 \
        python3=3.10.6-1~22.04 \
	python3-venv=3.10.6-1~22.04 \
	python3-distutils=3.10.6-1~22.04 \
	python3-apt=2.4.9 && \
    rm -rf /var/lib/apt/lists/*

#Set python3 to point to python3.10
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.10 1

#Configure SSH and create ubuntu user
RUN mkdir /var/run/sshd && \
    useradd -m -s /bin/bash ubuntu && echo "ubuntu:ubuntu" | chpasswd && \
    adduser ubuntu sudo && \
    mkdir -p /home/ubuntu/.ssh && chown ubuntu:ubuntu /home/ubuntu/.ssh

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]

