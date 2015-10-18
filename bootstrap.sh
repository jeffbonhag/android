#!/bin/bash
set -e -x
apt-get update
apt-get -y install openjdk-6-jdk
apt-get -y install bison g++-multilib git gperf libxml2-utils make \
python-networkx zip lib32z1 xsltproc flex libswitch-perl

mkdir /usr/local/bin
PATH=/usr/local/bin:$PATH
curl https://storage.googleapis.com/git-repo-downloads/repo > /usr/local/bin/repo
chmod a+x /usr/local/bin/repo

function init() {
  mkdir WORKING_DIRECTORY
  cd WORKING_DIRECTORY
  BRANCH=android-4.1.2_r2.1
  repo init -u https://android.googlesource.com/platform/manifest -b ${BRANCH}
}

function sync() {
  repo sync
}

function config() {
  git config --global user.name "Jeff Bonhag"
  git config --global user.email "jeff@thebonhags.com"
}

function build() {
  source build/envsetup.sh
  lunch full-eng
  make
}
