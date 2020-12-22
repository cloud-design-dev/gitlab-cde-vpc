#!/bin/bash 

## Update machine
DEBIAN_FRONTEND=noninteractive apt -qqy update
DEBIAN_FRONTEND=noninteractive apt-get -qqy -o Dpkg::Options::='--force-confdef' -o Dpkg::Options::='--force-confold' upgrade

## Install Docker
DEBIAN_FRONTEND=noninteractive apt -qqy -o Dpkg::Options::='--force-confdef' -o Dpkg::Options::='--force-confold' install curl unzip python3 python3-pip python3-apt

curl -L "https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.deb.sh" | bash


gitlab-runner register \
  --non-interactive \
  --url "https://${gitlab_url}/" \
  --registration-token "${registration_token}" \
  --executor "docker" \
  --docker-image alpine:latest \
  --description "docker-runner" \
  --tag-list "docker,ibm" \
  --run-untagged="true" \
  --locked="false" \
  --access-level="not_protected"
