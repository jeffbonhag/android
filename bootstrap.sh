#!/bin/bash
set -e -x
exec > >(tee /var/log/user-data.log|logger -t user-data ) 2>&1
echo BEGIN
date '+%Y-%m-%d %H:%M:%S'
apt-get update
apt-get -y install openjdk-6-jdk
apt-get -y install bison g++-multilib git gperf libxml2-utils make \
python-networkx zip lib32z1 xsltproc flex libswitch-perl

mkdir -p /usr/local/bin
PATH=/usr/local/bin:$PATH
curl https://storage.googleapis.com/git-repo-downloads/repo > /usr/local/bin/repo
chmod a+x /usr/local/bin/repo

function config() {
  git config --global user.name "Jeff Bonhag"
  git config --global user.email "jeff@thebonhags.com"
  git config --global color.ui true
}

function init() {
  mkdir WORKING_DIRECTORY
  cd WORKING_DIRECTORY
  BRANCH=android-4.1.2_r2.1
  repo init -u https://android.googlesource.com/platform/manifest -b ${BRANCH}
}

function sync() {
  repo sync
  # annoying false-positive java version thing
  ed -s build/core/main.mk <<< $'g/$(error stop)/d\nw'
}

function build() {
  source build/envsetup.sh
  lunch full-eng
  make
}

function kernel() {
  git clone https://github.com/jeffbonhag/mystul.git
  cd mystul/
  tar xvf mystul-3.4.10-c3a41c4.tar.gz 
  cd mystul-3.4.10-c3a41c4/
  git clone https://android.googlesource.com/platform/prebuilts/gcc/linux-x86/arm/arm-eabi-4.6
  export TOP=$PWD
  export PATH=$TOP/arm-eabi-4.6/bin:$PATH
  export ARCH=arm
  export SUBARCH=arm
  export CROSS_COMPILE=arm-eabi-
  make operaul_defconfig
  make
}
