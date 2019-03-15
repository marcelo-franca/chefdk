#!/bin/bash
sha256="83b96eb28891d3f89d58c3ffefa61c0d8aa605911c3b90d8c5cb92a75602e56d"
LOCAL_FILE="/tmp/chefdk_3.8.14-1_amd64.deb"
chefdk_url="https://packages.chef.io/files/stable/chefdk/3.8.14\
/ubuntu/18.04/chefdk_3.8.14-1_amd64.deb"

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
