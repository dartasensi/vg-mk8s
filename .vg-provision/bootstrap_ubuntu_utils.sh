#!/bin/bash

# OS update & upgrade
sudo apt-get -qq -y update && sudo apt-get -qq -y upgrade

# Utils installation
echo "updating and installing utils packages..."
sudo apt-get -qq -y update && sudo apt-get -qq -y install \
        tree \
        screen \
		bash-completion

# Configuring screen for vagrant and root
SCREENRC_SRC=/vagrant/.vg-provision/.screenrc
SCREENRC_OWN=
SCREENRC_DST=
if [[ -f "${SCREENRC_SRC}" ]] ; then
  echo "applying custom screenrc to ~vagrant"
  SCREENRC_DST=/home/vagrant/.screenrc
  SCREENRC_OWN=vagrant:vagrant
  sudo -e cp ${SCREENRC_SRC} ${SCREENRC_DST}
  sudo -e chown ${SCREENRC_OWN} ${SCREENRC_DST}
  # Fix attribs
  sudo -e chmod ugo-x ${SCREENRC_DST}
  
  echo "applying custom screenrc to ~root"
  SCREENRC_DST=/root/.screenrc
  SCREENRC_OWN=root:root
  sudo -e cp ${SCREENRC_SRC} ${SCREENRC_DST}
  sudo -e chown ${SCREENRC_OWN} ${SCREENRC_DST}
  # Fix attribs
  sudo -e chmod ugo-x ${SCREENRC_DST}
  
fi
