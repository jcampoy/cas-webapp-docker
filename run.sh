#!/bin/bash
docker stop cas &>/dev/null
docker rm cas -f &>/dev/null

cas_version=$1

read -p "Docker user: " docker_user;

if [ $# -eq 0 ] || [ -z "$cas_version" ]
  then
    echo "No CAS version is specified."
    read -p "Provide a tag for the CAS image you are about to run (i.e. 5.3.2): " cas_version;
fi

if [ ! -z "$cas_version" ]
  then
	docker run -d -p 9090:8080 -p 9443:8443 --name="cas" $docker_user/cas:v$cas_version
	docker logs -f cas
  else
  	echo "No image tag is provided."	
fi
