FROM rust:1.65.0-buster

RUN apt-get update && \
    apt-get install -y sudo build-essential bash && \
    apt-get clean && \
    rustup component add rls rust-analysis rust-src rustfmt clippy && \
    cargo install cargo-edit cargo-watch


ARG host_uid
ARG host_gid
ARG user
ARG group

RUN groupadd -f -r --gid ${host_gid} ${group}  && \
    useradd -m -r --uid ${host_uid} --gid ${host_gid} ${user} && \
    usermod -aG ${group} ${user} && \
    echo "%${user}     ALL=(ALL)    NOPASSWD:ALL" >> /etc/sudoers.d/${group}-group    

RUN mkdir /workspace && chown ${group}:${user} /workspace -R
USER ${host_uid}
SHELL ["/bin/bash", "-c"] 
