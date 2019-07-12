#!/usr/bin/env bash
############################################################
######                                                     #
#####   Please                      AutoGenerated...      ##
####      Do NOT                    was                  ###
###        Manually                It                   ####
##          Change this Script...                      #####
#                                                     ######
############################################################
############################################################
#INSTALLATION INSTRUCTIONS                                #
##########################################################
#------------------------- for Debian Flavored Linux Distributions
#
#-------------------------------------------------------|
# 0/ Quick MISP Instance on Debian Based Linux - Status |
#-------------------------------------------------------|
#
#    20190302: Ubuntu 18.04.2 tested and working. -- sCl
#    20190208: Kali Linux tested and working. -- sCl
#
#
#-------------------------------------------------------------------------------------------------|
# 1/ For other Debian based Linux distributions, download script and run as **unprivileged** user |
#-------------------------------------------------------------------------------------------------|
#
# The following installs only MISP Core:
# $ wget --no-cache -O /tmp/INSTALL.sh https://raw.githubusercontent.com/MISP/MISP/2.4/INSTALL/INSTALL.sh ; bash /tmp/INSTALL.sh -c
#
# This will install MISP Core and misp-modules
# $ wget --no-cache -O /tmp/INSTALL.sh https://raw.githubusercontent.com/MISP/MISP/2.4/INSTALL/INSTALL.sh ; bash /tmp/INSTALL.sh -c -M
#
#
#-------------------------------------------------------|
# 2/ For Kali, download and run Installer Script        |
#-------------------------------------------------------|
#
# To install MISP on Kali copy paste the following to your r00t shell:
# # wget --no-cache -O /tmp/misp-kali.sh https://raw.githubusercontent.com/MISP/MISP/2.4/INSTALL/INSTALL.sh && bash /tmp/misp-kali.sh
# /!\ Please read the installer script before randomly doing the above.
# The script is tested on a plain vanilla Kali Linux Boot CD and installs quite a few dependencies.
#
#
#----------------------------------------------------------|
# 3/ The following script has been partially autogenerated |
#----------------------------------------------------------|
#
# To generate this script yourself, the following steps need to be taken.
# $ git clone https://github.com/SteveClement/xsnippet.git
# Make sure xsnippet resides somewhere in your $PATH - It is a shell script so a simple, copy to somewhere sane is enough.
# $ git clone https://github.com/MISP/MISP.git
# $ cd MISP/INSTALL ; ./INSTALL.tpl.sh
#
##
###
####----------------\
##   Developer Note |
####--------------------------------------------------------------------------------------------------|
##   In theory the order does not matter as everything is a self-contained function.                  |
#    That said, ideally leave the order as is and do NOT change the lines as they are place-holders.  |
#    Script files that do NOT have a #_name.sh are scripts that have NO functions. This is by design. |
#-----------------------------------------------------------------------------------------------------|
#
# ToC #
#
#### BEGIN AUTOMATED SECTION ####
#
## 0_global-vars.sh ##
## 0_support-functions.sh ##
## 0_apt-upgrade.sh ##
## 0_sudoKeeper.sh ##
## 0_installCoreDeps.sh ##
## 0_installDepsPhp73.sh ##
## 0_installDepsPhp72.sh ##
## 0_installDepsPhp70.sh ##
## 1_prepareDB.sh ##
## 1_apacheConfig.sh ##
## 1_mispCoreInstall.sh ##
## 1_installCake.sh ##
## 2_permissions.sh ##
## 2_configMISP.sh ##
## 2_core-cake.sh ##
## 2_gnupg.sh ##
## 2_logRotation.sh ##
## 2_backgroundWorkers.sh ##
## 3_misp-modules.sh ##
## 4_misp-dashboard.sh ##
## 4_misp-dashboard-cake.sh ##
## 5_mail_to_misp.sh ##
## 6_ssdeep.sh ##
## 6_viper.sh ##

# No functions scripts:
## apt-upgrade.sh ##
## postfix.sh ##
## interfaces.sh ##
#
### END AUTOMATED SECTION ###

# This function will generate the main installer.
# It is a helper function for the maintainers for the installer.

colors () {
  # Some colors for easier debug and better UX (not colorblind compatible, PR welcome)
  RED='\033[0;31m'
  GREEN='\033[0;32m'
  LBLUE='\033[1;34m'
  YELLOW='\033[0;33m'
  HIDDEN='\e[8m'
  NC='\033[0m'
}

generateInstaller () {
  if [ ! -f $(which xsnippet) ]; then
    echo 'xsnippet is NOT installed. Clone the repository below and copy the xsnippet shell script somehwere in your $PATH'
    echo "git clone https://github.com/SteveClement/xsnippet.git"
    exit 1
  fi

  if [[ $(echo $0 |grep -e '^\.\/') != "./INSTALL.tpl.sh" ]]; then
    echo -e "${RED}iAmError!${NC}"
    echo -e "To generate the installer call it with './INSTALL.tpl.sh' otherwise things will break."
    echo -e "You called: ${RED}$0${NC}"
    exit 1
  fi

  mkdir installer ; cd installer
  cp ../INSTALL.tpl.sh .

  # Pull code snippets out of Main Install Documents
  for f in `echo INSTALL.ubuntu1804.md xINSTALL.debian9.md INSTALL.kali.md xINSTALL.debian10.md xINSTALL.tsurugi.md xINSTALL.debian9-postgresql.md xINSTALL.ubuntu1804.with.webmin.md`; do
    xsnippet . ../../docs/${f}
  done

  # Pull out code snippets from generic Install Documents
  for f in `echo globalVariables.md mail_to_misp-debian.md MISP_CAKE_init.md misp-dashboard-debian.md misp-modules-debian.md gnupg.md ssdeep-debian.md sudo_etckeeper.md supportFunctions.md viper-debian.md`; do
    xsnippet . ../../docs/generic/${f}
  done

  # TODO: Fix the below.
  # $ for f in `echo ls [0-9]_*`; do
  # $   perl -pe 's/## ${f} ##/`cat ${f}`/ge' -i INSTALL.sh
  # $ done
  #
  # Temporary copy/paste holder
  perl -pe 's/^## 0_global-vars.sh ##/`cat 0_global-vars.sh`/ge' -i INSTALL.tpl.sh
  perl -pe 's/^## 0_apt-upgrade.sh ##/`cat 0_apt-upgrade.sh`/ge' -i INSTALL.tpl.sh
  perl -pe 's/^## 0_sudoKeeper.sh ##/`cat 0_sudoKeeper.sh`/ge' -i INSTALL.tpl.sh
  perl -pe 's/^## 0_installCoreDeps.sh ##/`cat 0_installCoreDeps.sh`/ge' -i INSTALL.tpl.sh
  perl -pe 's/^## 0_installDepsPhp73.sh ##/`cat 0_installDepsPhp73.sh`/ge' -i INSTALL.tpl.sh
  perl -pe 's/^## 0_installDepsPhp72.sh ##/`cat 0_installDepsPhp72.sh`/ge' -i INSTALL.tpl.sh
  perl -pe 's/^## 0_installDepsPhp70.sh ##/`cat 0_installDepsPhp70.sh`/ge' -i INSTALL.tpl.sh
  perl -pe 's/^## 1_prepareDB.sh ##/`cat 1_prepareDB.sh`/ge' -i INSTALL.tpl.sh
  perl -pe 's/^## 1_apacheConfig.sh ##/`cat 1_apacheConfig.sh`/ge' -i INSTALL.tpl.sh
  perl -pe 's/^## 1_mispCoreInstall.sh ##/`cat 1_mispCoreInstall.sh`/ge' -i INSTALL.tpl.sh
  perl -pe 's/^## 1_installCake.sh ##/`cat 1_installCake.sh`/ge' -i INSTALL.tpl.sh
  perl -pe 's/^## 2_permissions.sh ##/`cat 2_permissions.sh`/ge' -i INSTALL.tpl.sh
  perl -pe 's/^## 2_configMISP.sh ##/`cat 2_configMISP.sh`/ge' -i INSTALL.tpl.sh
  perl -pe 's/^## 0_support-functions.sh ##/`cat 0_support-functions.sh`/ge' -i INSTALL.tpl.sh
  perl -pe 's/^## 2_gnupg.sh ##/`cat 2_gnupg.sh`/ge' -i INSTALL.tpl.sh
  perl -pe 's/^## 2_logRotation.sh ##/`cat 2_logRotation.sh`/ge' -i INSTALL.tpl.sh
  perl -pe 's/^## 2_backgroundWorkers.sh ##/`cat 2_backgroundWorkers.sh`/ge' -i INSTALL.tpl.sh
  perl -pe 's/^## 2_core-cake.sh ##/`cat 2_core-cake.sh`/ge' -i INSTALL.tpl.sh
  perl -pe 's/^## 3_misp-modules.sh ##/`cat 3_misp-modules.sh`/ge' -i INSTALL.tpl.sh
  perl -pe 's/^## 4_misp-dashboard-cake.sh ##/`cat 4_misp-dashboard-cake.sh`/ge' -i INSTALL.tpl.sh
  perl -pe 's/^## 4_misp-dashboard.sh ##/`cat 4_misp-dashboard.sh`/ge' -i INSTALL.tpl.sh
  perl -pe 's/^## 5_mail_to_misp.sh ##/`cat 5_mail_to_misp.sh`/ge' -i INSTALL.tpl.sh
  perl -pe 's/^## 6_viper.sh ##/`cat 6_viper.sh`/ge' -i INSTALL.tpl.sh
  perl -pe 's/^## 6_ssdeep.sh ##/`cat 6_ssdeep.sh`/ge' -i INSTALL.tpl.sh

  cp INSTALL.tpl.sh ../INSTALL.sh
  cd ..
  for ALGO in $(echo "1 256 384 512"); do
    shasum -a ${ALGO} INSTALL.sh > INSTALL.sh.sha${ALGO}
  done
  [[ "$(which rhash > /dev/null 2>&1 ; echo $?)" == "0" ]] && rhash --sfv --sha1 --sha256 --sha384 --sha512 INSTALL.sh > INSTALL.sh.sfv
  rm -rf installer
  echo -e "${LBLUE}Generated INSTALL.sh${NC}"
  exit 0
}

# Simple debug function with message

# Make sure no alias exists
if [[ $(type -t debug) == "alias" ]]; then unalias debug; fi
debug () {
  echo -e "${RED}Next step:${NC} ${GREEN}$1${NC}" > /dev/tty
  if [ ! -z $DEBUG ]; then
    NO_PROGRESS=1
    echo -e "${RED}Debug Mode${NC}, press ${LBLUE}enter${NC} to continue..." > /dev/tty
    exec 3>&1
    read
  else
    # [Set up conditional redirection](https://stackoverflow.com/questions/8756535/conditional-redirection-in-bash)
    #exec 3>&1 &>/dev/null
    :
  fi
}

installSupported () {
  space
  echo "Proceeding with the installation of MISP core"
  space

  # Set Base URL - functionLocation('generic/supportFunctions.md')
  [[ -n $CORE ]]   || [[ -n $ALL ]] && setBaseURL
  progress 4

  # Check if sudo is installed and etckeeper - functionLocation('generic/sudo_etckeeper.md')
  [[ -n $CORE ]]   || [[ -n $ALL ]] && checkSudoKeeper 2> /dev/null > /dev/null
  [[ ! -z ${MISP_USER} ]] && [[ ! -f /etc/sudoers.d/misp ]] && echo "%${MISP_USER} ALL=(ALL:ALL) NOPASSWD:ALL" |sudo tee /etc/sudoers.d/misp
  progress 4

  # Set locale if not set - functionLocation('generic/supportFunctions.md')
  checkLocale

  # Upgrade system to make sure we install  the latest packages - functionLocation('INSTALL.ubuntu1804.md')
  [[ -n $CORE ]]   || [[ -n $ALL ]] && aptUpgrade 2> /dev/null > /dev/null
  progress 4

  # TODO: Double check how the user is added and subsequently used during the install.
  # TODO: Work on possibility to install as user X and install MISP for user Y
  # TODO: Check if logout needed. (run SUDO_USER in installer)
  # <snippet-begin add-user.sh>
  # TODO: Double check how to properly handle postfix
  # <snippet-begin postfix.sh>

  # Pull in all possible MISP Environment variables - functionLocation('generic/globalVariables.md')
  [[ -n $CORE ]]   || [[ -n $ALL ]] && MISPvars
  progress 4

  # Check if MISP user is installed and we do not run as root - functionLocation('generic/supportFunctions.md')
  checkID
  progress 4

  # Starting friendly UI spinner
  #spin &
  #SPIN_PID=$!
  #disown
  #trap "kill -9 $SPIN_PID" `seq 0 15`

  # Install Core Dependencies - functionLocation('INSTALL.ubuntu1804.md')
  [[ -n $CORE ]]   || [[ -n $ALL ]] && installCoreDeps
  progress 4

  if [[ "$1" =~ ^PHP= ]]; then
    PHP_VER=$(echo $1 |cut -f2 -d=)
    if [[ "$PHP_VER" == "7.2" ]]; then
      # Install PHP 7.2 Dependencies - functionLocation('INSTALL.ubuntu1804.md')
      [[ -n $CORE ]]   || [[ -n $ALL ]] && installDepsPhp72
    elif [[ "$PHP_VER" == "7.3" ]]; then
      # Install PHP 7.3 Dependencies - functionLocation('generic/supportFunctions.md')
      [[ -n $CORE ]]   || [[ -n $ALL ]] && installDepsPhp73
    elif [[ "$PHP_VER" == "7.0" ]]; then
      # Install PHP 7.0 Dependencies - functionLocation('generic/supportFunctions.md')
      [[ -n $CORE ]]   || [[ -n $ALL ]] && installDepsPhp70
    fi
  else
      # Install PHP 7.2 Dependencies - functionLocation('INSTALL.ubuntu1804.md')
      [[ -n $CORE ]]   || [[ -n $ALL ]] && installDepsPhp72
  fi
  progress 4

  # Install Core MISP - functionLocation('INSTALL.ubuntu1804.md')
  [[ -n $CORE ]]   || [[ -n $ALL ]] && installCore
  progress 4

  # Install PHP Cake - functionLocation('INSTALL.ubuntu1804.md')
  [[ -n $CORE ]]   || [[ -n $ALL ]] && installCake
  progress 4

  # Make sure permissions are sane - functionLocation('INSTALL.ubuntu1804.md')
  [[ -n $CORE ]]   || [[ -n $ALL ]] && permissions 2> /dev/null > /dev/null
  progress 4

  # TODO: Mysql install functions, make it upgrade safe, double check
  # Setup Databse - functionLocation('INSTALL.ubuntu1804.md')
  [[ -n $CORE ]]   || [[ -n $ALL ]] && prepareDB 2> /dev/null > /dev/null
  progress 4

  # Roll Apache Config - functionLocation('INSTALL.ubuntu1804.md')
  [[ -n $CORE ]]   || [[ -n $ALL ]] && apacheConfig 2> /dev/null > /dev/null
  progress 4

  # Setup log logrotate - functionLocation('INSTALL.ubuntu1804.md')
  [[ -n $CORE ]]   || [[ -n $ALL ]] && logRotation 2> /dev/null > /dev/null
  progress 4

  # Generate MISP Config files - functionLocation('INSTALL.ubuntu1804.md')
  [[ -n $CORE ]]   || [[ -n $ALL ]] && configMISP 2> /dev/null > /dev/null
  progress 4

  # Generate GnuPG key - functionLocation('generic/gnupg.md')
  [[ -n $CORE ]]   || [[ -n $ALL ]] && setupGnuPG 2> /dev/null > /dev/null
  progress 4

  # Setup and start background workers - functionLocation('INSTALL.ubuntu1804.md')
  [[ -n $CORE ]]   || [[ -n $ALL ]] && backgroundWorkers 2> /dev/null > /dev/null
  progress 4

  # Run cake CLI for the core installation - functionLocation('generic/MISP_CAKE_init.md')
  [[ -n $CORE ]]   || [[ -n $ALL ]] && coreCAKE 2> /dev/null > /dev/null
  progress 4

  # Update Galaxies, Template Objects, Warning Lists, Notice Lists, Taxonomies - functionLocation('generic/MISP_CAKE_init.md')
  [[ -n $CORE ]]   || [[ -n $ALL ]] && updateGOWNT 2> /dev/null > /dev/null
  progress 4

  # Disable spinner
  #(kill $SPIN_PID 2>&1) >/dev/null

  # Check if /usr/local/src is writeable by target install user - functionLocation('generic/supportFunctions.md')
  [[ -n $CORE ]]   || [[ -n $ALL ]] && checkUsrLocalSrc
  progress 4

  ## Resume spinner
  #spin &
  #SPIN_PID=$!
  #disown
  #trap "kill -9 $SPIN_PID" `seq 0 15`

  # Install misp-modules - functionLocation('generic/misp-modules-debian.md')
  [[ -n $MODULES ]]   || [[ -n $ALL ]] && mispmodules
  progress 4

  # Install Viper - functionLocation('generic/viper-debian.md')
  [[ -n $VIPER ]]     || [[ -n $ALL ]] && viper
  progress 4

  # Install ssdeep - functionLocation('generic/ssdeep-debian.md')
  [[ -n $SSDEEP ]]     || [[ -n $ALL ]] && ssdeep
  progress 4

  # Install misp-dashboard - functionLocation('generic/misp-dashboard-debian.md')
  [[ -n $DASHBOARD ]] || [[ -n $ALL ]] && mispDashboard ; dashboardCAKE 2> /dev/null > /dev/null
  progress 4

  # Install Mail2MISP - functionLocation('generic/mail_to_misp-debian.md')
  [[ -n $MAIL2 ]]     || [[ -n $ALL ]] && mail2misp
  progress 2

  # Run tests
  runTests
  progress 2

  # Run final script to inform the User what happened - functionLocation('generic/supportFunctions.md')
  theEnd
}

# Main Kalin Install function
installMISPonKali () {
  # Kali might have a bug on installs where libc6 is not up to date, this forces bash and libc to update - functionLocation('')
  kaliUpgrade 2> /dev/null > /dev/null

  # Set locale if not set - functionLocation('generic/supportFunctions.md')
  checkLocale

  # Set Base URL - functionLocation('generic/supportFunctions.md')
  setBaseURL

  # Install PHP 7.3 Dependencies - functionLocation('generic/supportFunctions.md')
  installDepsPhp73 2> /dev/null > /dev/null

  # Set custom Kali only variables and tweaks
  space
  # The following disables sleep on kali/gnome
  ### FIXME: Disabling for now, maybe source of some issues.
  ##disableSleep 2> /dev/null > /dev/null
  ##debug "Sleeping 3 seconds to make sure the disable sleep does not confuse the execution of the script."
  ##sleep 3

  # Kali specific dependencies - functionLocation('generic/supportFunctions.md')
  debug "Installing dependencies"
  installDeps

  # Install Core Dependencies - functionLocation('INSTALL.ubuntu1804.md')
  installCoreDeps

  debug "Enabling redis and gnupg modules"
  phpenmod -v 7.3 redis
  phpenmod -v 7.3 gnupg

  debug "Apache2 ops: dismod: status php7.2 - dissite: 000-default enmod: ssl rewrite headers php7.3 ensite: default-ssl"
  a2dismod status 2> /dev/null > /dev/null
  a2dismod php7.2 2> /dev/null > /dev/null
  a2enmod ssl rewrite headers php7.3 2> /dev/null > /dev/null
  a2dissite 000-default 2> /dev/null > /dev/null
  a2ensite default-ssl 2> /dev/null > /dev/null

  debug "Restarting mysql.service"
  systemctl restart mysql.service 2> /dev/null > /dev/null

  debug "Fixing redis rc script on Kali"
  fixRedis 2> /dev/null > /dev/null

  debug "git clone, submodule update everything"
  mkdir $PATH_TO_MISP
  chown $WWW_USER:$WWW_USER $PATH_TO_MISP
  cd $PATH_TO_MISP
  $SUDO_WWW git clone https://github.com/MISP/MISP.git $PATH_TO_MISP

  $SUDO_WWW git config core.filemode false

  cd $PATH_TO_MISP
  $SUDO_WWW git submodule update --init --recursive 2> /dev/null > /dev/null
  # Make git ignore filesystem permission differences for submodules
  $SUDO_WWW git submodule foreach --recursive git config core.filemode false

  cd $PATH_TO_MISP/app/files/scripts
  $SUDO_WWW git clone https://github.com/CybOXProject/python-cybox.git 2> /dev/null > /dev/null
  $SUDO_WWW git clone https://github.com/STIXProject/python-stix.git 2> /dev/null > /dev/null
  $SUDO_WWW git clone https://github.com/CybOXProject/mixbox.git 2> /dev/null > /dev/null
  $SUDO_WWW git clone https://github.com/MAECProject/python-maec.git 2> /dev/null > /dev/null


  mkdir /var/www/.cache/

  MISP_USER_HOME=$(sudo -Hiu $MISP_USER env | grep HOME |cut -f 2 -d=)
  mkdir $MISP_USER_HOME/.cache
  chown $MISP_USER:$MISP_USER $MISP_USER_HOME/.cache
  chown $WWW_USER:$WWW_USER /var/www/.cache

  debug "Generating rc.local"
  genRCLOCAL

  debug "Setting up main MISP virtualenv"
  # Needs virtualenv
  $SUDO_WWW virtualenv -p python3 ${PATH_TO_MISP}/venv

  debug "Installing MISP dashboard"
  mispDashboard

  debug "Installing python-cybox"
  cd $PATH_TO_MISP/app/files/scripts/python-cybox
  $SUDO_WWW ${PATH_TO_MISP}/venv/bin/pip install . 2> /dev/null > /dev/null

  debug "Installing python-stix"
  cd $PATH_TO_MISP/app/files/scripts/python-stix
  $SUDO_WWW ${PATH_TO_MISP}/venv/bin/pip install . 2> /dev/null > /dev/null

  debug "Install maec"
  cd $PATH_TO_MISP/app/files/scripts/python-maec
  $SUDO_WWW ${PATH_TO_MISP}/venv/bin/pip install . 2> /dev/null > /dev/null

  # install STIX2.0 library to support STIX 2.0 export
  debug "Installing cti-python-stix2"
  cd ${PATH_TO_MISP}/cti-python-stix2
  $SUDO_WWW ${PATH_TO_MISP}/venv/bin/pip install -I . 2> /dev/null > /dev/null

  debug "Installing mixbox"
  cd $PATH_TO_MISP/app/files/scripts/mixbox
  $SUDO_WWW ${PATH_TO_MISP}/venv/bin/pip install . 2> /dev/null > /dev/null

  # install PyMISP
  debug "Installing PyMISP"
  cd $PATH_TO_MISP/PyMISP
  $SUDO_WWW ${PATH_TO_MISP}/venv/bin/pip install . 2> /dev/null > /dev/null

  # install pydeep
  $SUDO_WWW ${PATH_TO_MISP}/venv/bin/pip install git+https://github.com/kbandla/pydeep.git 2> /dev/null > /dev/null

  # install lief
  $SUDO_WWW ${PATH_TO_MISP}/venv/bin/pip install https://github.com/lief-project/packages/raw/lief-master-latest/pylief-0.9.0.dev.zip 2> /dev/null > /dev/null

  # install python-magic
  $SUDO_WWW ${PATH_TO_MISP}/venv/bin/pip install python-magic 2> /dev/null > /dev/null

  # install plyara
  $SUDO_WWW ${PATH_TO_MISP}/venv/bin/pip install plyara 2> /dev/null > /dev/null

  # install zmq needed by mispzmq
  $SUDO_WWW ${PATH_TO_MISP}/venv/bin/pip install zmq 2> /dev/null > /dev/null

  # Install Crypt_GPG and Console_CommandLine
  debug "Installing pear Console_CommandLine"
  pear install ${PATH_TO_MISP}/INSTALL/dependencies/Console_CommandLine/package.xml
  debug "Installing pear Crypt_GPG"
  pear install ${PATH_TO_MISP}/INSTALL/dependencies/Crypt_GPG/package.xml


  debug "Installing composer with php 7.3 updates"
  composer73

  $SUDO_WWW cp -fa $PATH_TO_MISP/INSTALL/setup/config.php $PATH_TO_MISP/app/Plugin/CakeResque/Config/config.php

  chown -R $WWW_USER:$WWW_USER $PATH_TO_MISP
  chmod -R 750 $PATH_TO_MISP
  chmod -R g+ws $PATH_TO_MISP/app/tmp
  chmod -R g+ws $PATH_TO_MISP/app/files
  chmod -R g+ws $PATH_TO_MISP/app/files/scripts/tmp

  debug "Setting up database"
  if [[ ! -e /var/lib/mysql/misp/users.ibd ]]; then
    echo "
      set timeout 10
      spawn mysql_secure_installation
      expect \"Enter current password for root (enter for none):\"
      send -- \"\r\"
      expect \"Set root password?\"
      send -- \"y\r\"
      expect \"New password:\"
      send -- \"${DBPASSWORD_ADMIN}\r\"
      expect \"Re-enter new password:\"
      send -- \"${DBPASSWORD_ADMIN}\r\"
      expect \"Remove anonymous users?\"
      send -- \"y\r\"
      expect \"Disallow root login remotely?\"
      send -- \"y\r\"
      expect \"Remove test database and access to it?\"
      send -- \"y\r\"
      expect \"Reload privilege tables now?\"
      send -- \"y\r\"
      expect eof" | expect -f -

    mysql -u $DBUSER_ADMIN -p$DBPASSWORD_ADMIN -e "CREATE DATABASE $DBNAME;"
    mysql -u $DBUSER_ADMIN -p$DBPASSWORD_ADMIN -e "GRANT USAGE ON *.* TO $DBUSER_MISP@localhost IDENTIFIED BY '$DBPASSWORD_MISP';"
    mysql -u $DBUSER_ADMIN -p$DBPASSWORD_ADMIN -e "GRANT ALL PRIVILEGES ON $DBNAME.* TO '$DBUSER_MISP'@'localhost';"
    mysql -u $DBUSER_ADMIN -p$DBPASSWORD_ADMIN -e "FLUSH PRIVILEGES;"

    enableServices

    $SUDO_WWW cat $PATH_TO_MISP/INSTALL/MYSQL.sql | mysql -u $DBUSER_MISP -p$DBPASSWORD_MISP $DBNAME

    echo "<?php
  class DATABASE_CONFIG {
          public \$default = array(
                  'datasource' => 'Database/Mysql',
                  //'datasource' => 'Database/Postgres',
                  'persistent' => false,
                  'host' => '$DBHOST',
                  'login' => '$DBUSER_MISP',
                  'port' => 3306, // MySQL & MariaDB
                  //'port' => 5432, // PostgreSQL
                  'password' => '$DBPASSWORD_MISP',
                  'database' => '$DBNAME',
                  'prefix' => '',
                  'encoding' => 'utf8',
          );
  }" | $SUDO_WWW tee $PATH_TO_MISP/app/Config/database.php 2> /dev/null > /dev/null
  else
    echo "There might be a database already existing here: /var/lib/mysql/misp/users.ibd"
    echo "Skipping any creations…"
    sleep 3
  fi

  debug "Generating Certificate"
  openssl req -newkey rsa:4096 -days 365 -nodes -x509 \
  -subj "/C=${OPENSSL_C}/ST=${OPENSSL_ST}/L=${OPENSSL_L}/O=${OPENSSL_O}/OU=${OPENSSL_OU}/CN=${OPENSSL_CN}/emailAddress=${OPENSSL_EMAILADDRESS}" \
  -keyout /etc/ssl/private/misp.local.key -out /etc/ssl/private/misp.local.crt

  debug "Generating Apache Conf"
  genApacheConf

  echo "127.0.0.1 misp.local" | tee -a /etc/hosts

  debug "Disabling site default-ssl, enabling misp-ssl"
  a2dissite default-ssl
  a2ensite misp-ssl

  for key in upload_max_filesize post_max_size max_execution_time max_input_time memory_limit
  do
      sed -i "s/^\($key\).*/\1 = $(eval echo \${$key})/" $PHP_INI
  done

  debug "Restarting Apache2"
  systemctl restart apache2

  debug "Setting up logrotate"
  cp $PATH_TO_MISP/INSTALL/misp.logrotate /etc/logrotate.d/misp
  chmod 0640 /etc/logrotate.d/misp

  $SUDO_WWW cp -a $PATH_TO_MISP/app/Config/bootstrap.default.php $PATH_TO_MISP/app/Config/bootstrap.php
  $SUDO_WWW cp -a $PATH_TO_MISP/app/Config/core.default.php $PATH_TO_MISP/app/Config/core.php
  $SUDO_WWW cp -a $PATH_TO_MISP/app/Config/config.default.php $PATH_TO_MISP/app/Config/config.php

  chown -R $WWW_USER:$WWW_USER $PATH_TO_MISP/app/Config
  chmod -R 750 $PATH_TO_MISP/app/Config

  debug "Setting up GnuPG"
  setupGnuPG 2> /dev/null > /dev/null

  debug "Adding workers to systemd"
  chmod +x $PATH_TO_MISP/app/Console/worker/start.sh
  sudo cp $PATH_TO_MISP/INSTALL/misp-workers.service /etc/systemd/system/
  sudo systemctl daemon-reload
  sudo systemctl enable --now misp-workers

  debug "Running Core Cake commands"
  coreCAKE 2> /dev/null > /dev/null
  dashboardCAKE 2> /dev/null > /dev/null

  debug "Update: Galaxies, Template Objects, Warning Lists, Notice Lists, Taxonomies"
  updateGOWNT 2> /dev/null > /dev/null

  gitPullAllRCLOCAL

  checkUsrLocalSrc

  debug "Installing misp-modules"
  mispmodules

  debug "Installing Viper"
  viper

  debug "Installing ssdeep"
  ssdeep
  phpenmod -v 7.3 ssdeep

  debug "Setting permissions"
  permissions

  debug "Running Then End!"
  theEnd
}
# End installMISPonKali ()

## End Function Section ##

colors
debug "Checking if we are run as the installer template"
if [[ "$0" == "./INSTALL.tpl.sh" || "$(echo $0 |grep -o -e 'INSTALL.tpl.sh')" == "INSTALL.tpl.sh" ]]; then
  generateInstaller
fi

debug "Checking if we are uptodate and checksums match"
checkInstaller

space
debug "Setting MISP variables"
MISPvars
debug "Checking Linux distribution and flavour..."
checkFlavour

debug "Checking for parameters or Unattended Kali Install"
if [[ $# == 0 && $0 != "/tmp/misp-kali.sh" ]]; then
  usage
  exit 
else
  debug "Setting install options with given parameters."
  # The setOpt/checkOpt function lives in generic/supportFunctions.md
  setOpt $@
  checkOpt core && echo "${LBLUE}MISP${NC} ${GREEN}core${NC} selected"
  checkOpt viper && echo "${GREEN}Viper${NC} selected"
  checkOpt modules && echo "${LBLUE}MISP${NC} ${GREEN}modules${NC} selected"
  checkOpt dashboard && echo "${LBLUE}MISP${NC} ${GREEN}dashboard${NC} selected"
  checkOpt mail2 && echo "${GREEN}Mail 2${NC} ${LBLUE}MISP${NC} selected"
  checkOpt all && echo "${GREEN}All options${NC} selected"
  checkOpt pre && echo "${GREEN}Pre-flight checks${NC} selected"
  checkOpt unattended && echo "${GREEN}unattended${NC} install selected"
  checkOpt upgrade && echo "${GREEN}upgrade${NC} install selected"
  checkOpt force && echo "${GREEN}force${NC} install selected"

  # Check if at least core is selected if no other options that do not require core are set
  if [[ "$CORE" != "1" && "$ALL" != "1" && "$UPGRADE" != "1" && "$PRE" != "1" && "$0" != "/tmp/misp-kali.sh" ]]; then
    space
    usage
    echo "You need to at least select core, or -A to install everything."
    echo "$0 -c # Is the minima for install options"
    exit 1
  fi
fi

# Add upgrade option to do upgrade pre flight
[[ -n $PRE ]] && preInstall

[[ -n $UPGRADE ]] && upgrade

[[ -n $NUKE ]] && nuke && exit

# TODO: Move support map to top

SUPPORT_MAP="
x86_64-centos-8
x86_64-rhel-7
x86_64-rhel-8
x86_64-fedora-30
x86_64-debian-stretch
x86_64-debian-buster
x86_64-ubuntu-bionic
armv6l-raspbian-stretch
armv7l-raspbian-stretch
armv7l-debian-jessie
armv7l-debian-stretch
armv7l-debian-buster
armv7l-ubuntu-bionic
"

# Check if we actually support this configuration
if ! echo "$SUPPORT_MAP" | grep "$(uname -m)-$FLAVOUR-$dist_version" >/dev/null; then
  cat >&2 <<-'EOF'
    Either your platform is not easily detectable or is not supported by this
    installer script.
    Please visit the following URL for more detailed installation instructions:
    https://misp.github.io/MISP/
EOF
  exit 1
fi

# If Ubuntu is detected, figure out which release it is and run the according scripts
if [ "${FLAVOUR}" == "ubuntu" ]; then
  RELEASE=$(lsb_release -s -r| tr '[:upper:]' '[:lower:]')
  if [ "${RELEASE}" == "18.04" ]; then
    echo "Install on Ubuntu 18.04 LTS fully supported."
    echo "Please report bugs/issues here: https://github.com/MISP/MISP/issues"
    installSupported && exit || exit
  fi
  if [ "${RELEASE}" == "18.10" ]; then
    echo "Install on Ubuntu 18.10 partially supported, bye."
    installSupported && exit || exit
  fi
  if [ "${RELEASE}" == "19.04" ]; then
    echo "Install on Ubuntu 19.04 under development."
    echo "Please report bugs/issues here: https://github.com/MISP/MISP/issues"
    installSupported && exit || exit
    exit 1
  fi
  if [ "${RELEASE}" == "19.10" ]; then
    echo "Install on Ubuntu 19.10 not supported, bye"
    exit 1
  fi
  echo "Installation done!"
  exit
fi

# If Debian is detected, figure out which release it is and run the according scripts
if [ "${FLAVOUR}" == "debian" ]; then
  CODE=$(lsb_release -s -c| tr '[:upper:]' '[:lower:]')
  if [ "${CODE}" == "buster" ]; then
    echo "Install on Debian testing fully supported."
    echo "Please report bugs/issues here: https://github.com/MISP/MISP/issues"
    installSupported PHP=7.3 && exit || exit
  fi
  if [ "${CODE}" == "sid" ]; then
    echo "Install on Debian unstable not fully supported."
    echo "Please report bugs/issues here: https://github.com/MISP/MISP/issues"
    installSupported PHP=7.3 && exit || exit
  fi
  if [ "${CODE}" == "stretch" ]; then
    echo "Install on Debian stable fully supported."
    echo "Please report bugs/issues here: https://github.com/MISP/MISP/issues"
    installSupported PHP=7.0 && exit || exit
  fi
  echo "Installation done!"
  exit 0
fi

# If Tsurugi is detected, figure out which release it is and run the according scripts
if [ "${FLAVOUR}" == "tsurugi" ]; then
  CODE=$(lsb_release -s -c| tr '[:upper:]' '[:lower:]')
  if [ "${CODE}" == "bamboo" ]; then
    echo "Install on Tsurugi Lab partially supported."
    echo "Please report bugs/issues here: https://github.com/MISP/MISP/issues"
  fi
  if [ "${CODE}" == "soy sauce" ]; then
    echo "Install on Tsurugi Acquire partially supported."
    echo "Please report bugs/issues here: https://github.com/MISP/MISP/issues"
  fi
  echo "Installation done!"
  exit 0
fi

# If Kali Linux is detected, run the acccording scripts
if [ "${FLAVOUR}" == "kali" ]; then
  KALI=1
  kaliOnRootR0ckz
  installMISPonKali
  echo "Installation done!"
  exit
fi
