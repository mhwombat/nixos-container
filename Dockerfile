#
# To build this docker image:
#
#     podman build --tag nixos:1.0-base .
#
# To publish the image:
#
#     podman push localhost/mhwombat/data-mining:1.17-datascience-notebook docker.io/mhwombat/data-mining:1.17-datascience-notebook
#
FROM nix:2.3.15.1

USER root

# Switch to the NixOS channel
RUN nix-channel --add https://nixos.org/channels/nixos-21.05 nixpkgs
RUN nix-channel --update

# Install the NixOS installation tools
RUN nix-env -f '<nixpkgs>' -iA nixos-install-tools

# Generate your NixOS configuration
#RUN `which nixos-generate-config` --root /mnt
# START workaround for issue #5359
RUN `which nixos-generate-config` --root /
RUN mkdir /mnt/etc
RUN mv /etc/nixos /mnt/etc

# Set the grub device
RUN sed 's_# boot.loader.grub.device = .*_boot.loader.grub.device = "/";_' -i /mnt/etc/nixos/configuration.nix

# RUN PATH="$PATH" NIX_PATH="$NIX_PATH" `which nixos-install` --root /mnt --no-root-passwd --no-bootloader --show-trace --verbose --keep-going







# Build the NixOS closure and install it in the system profile
#RUN nix-env -p /nix/var/nix/profiles/system -f '<nixpkgs/nixos>' -I nixos-config=/etc/nixos/configuration.nix -iA system



# Temporary
#RUN touch /etc/NIXOS
#RUN touch /etc/NIXOS_LUSTRATE
#RUN /nix/var/nix/profiles/system/bin/switch-to-configuration boot

# LUSTRATE path
# RUN mkdir /mnt/etc
# RUN cp -r /etc/nixos /mnt/etc
#PATH="$PATH" NIX_PATH="$NIX_PATH" `which nixos-install` --root / --option sandbox false



# Set the hostname
#RUN HOSTNAME=`hostname` sed "s_# networking.hostName =.*_networking.hostName = \"${HOSTNAME}\";_" -i /etc/nixos/configuration.nix


# PATH="$PATH" NIX_PATH="$NIX_PATH" `which nixos-install` --root /



#RUN adduser -D -u 30000 -g nixbld -G nixbld nixbld

# RUN adduser -h /home/tempuser -s /bin/ash -D tempuser
# RUN echo "tempuser:password" | chpasswd
# # This user account and password is temporary

# USER tempuser

# RUN apk add curl
# RUN apk add xz
# RUN apk add sudo
# RUN echo '%wheel ALL=(ALL) ALL' > /etc/sudoers.d/wheel
# RUN adduser -h /home/nixbld -s /bin/ash -D nixbld
# RUN echo "nixbld:password" | chpasswd
# # This user account and password is temporary
# RUN adduser nixbld wheel
# RUN adduser nixbld nixbld

# USER nixbld
# WORKDIR /home/nixbld
# #RUN curl --location https://nixos.org/nix/install | sh
