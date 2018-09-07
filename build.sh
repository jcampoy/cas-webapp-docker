#!/bin/bash

cas_version=$1

KEYSTORE=$(pwd)/thekeystore
UPDATE_KEYSTORE=No


read -p "Docker username: " docker_user

echo "Keystore: $KEYSTORE"
while true; do
    read -p "Do you want to update the certificates? [y/n] " UPDATE_KEYSTORE;
    case $UPDATE_KEYSTORE in
        [Yy]* ) rm -f ./cert/cas*; . ./cert/updatekeystore.sh $KEYSTORE; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no [y/n].";;
    esac
done

if [ $# -eq 0 ] || [ -z "$cas_version" ]
  then
    echo "No CAS version is specified."
    read -p "Provide a tag for the CAS image you are about to build (default will be 5.3.2): " cas_version;
fi

if [ -z "$cas_version" ]
  then
    cas_version=5.3.2
fi

if [ ! -z "$cas_version" ]
  then
  	echo "Build CAS docker image tagged as v$cas_version"
	docker build --tag="$docker_user/cas:v$cas_version" . && echo "Built CAS image successfully tagged as v$cas_version" && docker images "$docker_user/cas:v$cas_version"
  else
  	echo "No image tag is provided."	
fi