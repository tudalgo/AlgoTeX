FROM ghcr.io/tudalgo/algotex:latest

# install pre-commit
RUN apt-get update \
    && apt-get -y install pre-commit sudo

# setup non-root user
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Create the user
RUN getent passwd $USER_UID && userdel -r -f $(getent passwd $USER_UID | cut -d: -f1) || true
RUN getent group $USER_GID || groupadd --gid $USER_GID $USERNAME
RUN id -u $USER_UID || useradd --uid $USER_UID --gid $USER_GID -m $USERNAME
# Add sudo support.
RUN echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME \
    # set the default shell to bash rather than sh
    && chsh -s /bin/bash $USERNAME

# set the default user.
USER $USERNAME
