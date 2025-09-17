FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

#Install SSH, Python 3.10, sudo, and monitoring tools
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        openssh-server sudo curl ca-certificates \
        python3 python3-apt python3-venv python3-distutils \
        htop net-tools && \
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

