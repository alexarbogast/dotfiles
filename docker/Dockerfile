FROM ubuntu:jammy

ARG INSTALL_DOTFILES=true

ARG USERNAME=ubuntu
ARG USER_UID=1000
ARG USER_GID=$USER_UID

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
  ubuntu-desktop \
  sudo \
  git \
  && rm -rf /var/lib/apt/lists/*

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

USER $USERNAME
RUN if [ "$INSTALL_DOTFILES" = "true" ]; then \
      git clone https://github.com/alexarbogast/dotfiles.git ~/.dotfiles && \
      ~/.dotfiles/install/bootstrap.sh -b && \
      ~/.dotfiles/install/install.sh -b \
        --exclude miniconda \
        --exclude alacritty && \
      sudo apt-get autoremove -y && \
      sudo apt-get clean && \
      sudo rm -rf /var/lib/apt/lists/*; \
    fi

USER root
