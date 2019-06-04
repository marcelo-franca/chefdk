#!/bin/bash
#
# getchefdk.sh - Get download of ChefDK
#
# Author     : Marcelo França <marcelo.frneves@gmail.com>
#
#  -------------------------------------------------------------
#   That's program get download of Chef Development Kit via URL then
#   check if sha256 signature match, else send error message
#   in console (STDOUT).
#
#  -------------------------------------------------------------
# Changelog:
#
#    v1.0 2019-03-15, Marcelo Franca:
#       - Arranging shell script "docker-entrypoint.sh" to other script
#         named "getchefdk.sh". This script can only download chefdk
#    v1.0 2019-06-04, Marcelo Franca:
#       - Update chefdk version.

sha256="4ca4eb63b5a71e90bba7e91539bc5ecbad596a8e9daaadb0d53bb2219af961c4"
chefdk_url="https://packages.chef.io/files/stable/chefdk/4.0.60/ubuntu/18.04/chefdk_4.0.60-1_amd64.deb"

if [[ $sha256 == $(wget --no-check-certificate $chefdk_url -O $LOCAL_FILE && \
  sha256sum $LOCAL_FILE | awk '{print $1}') ]]; then
    echo "Download completed"
    exit 0;
else
  echo "Download failure. The sha256 code do not been match!!";
  echo "sha256 code required: $sha256";
  echo "sha256 code received: $(sha256sum $LOCAL_FILE | awk '{print $1}')";
  echo "Please. Try again";
  exit 2;
fi
