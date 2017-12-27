#!/usr/bin/env bash

locale-gen en_US.UTF-8
echo 'LC_ALL="en_US.UTF-8"' >> /etc/environment

# Installs ruby 2.3 system wide from brightbox and dapp dependencies
apt-get update -y >/dev/null 2>&1
apt-get install apt-transport-https ca-certificates curl software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable"
apt-add-repository ppa:brightbox/ruby-ng -y
apt-get update -y >/dev/null 2>&1

apt-get install -y ruby2.3 cmake pkg-config ruby2.3-dev libssh2-1-dev libgit2-24
gem install dapp

dapp --version

# install docker 17.09.0
apt-get install "docker-ce=17.09.0~ce-0~ubuntu"


# Gitlab-runner
if [ ! -e /usr/local/bin/gitlab-runner ]
then
  echo "Download gitlab-runner..."
	curl -Ls -o /usr/local/bin/gitlab-runner https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-runner-linux-amd64
  chmod +x /usr/local/bin/gitlab-runner
	useradd --comment 'GitLab Runner' --create-home gitlab-runner --shell /bin/bash

	gitlab-runner install --user=gitlab-runner --working-directory=/home/gitlab-runner
	gitlab-runner start

  groupadd docker
  usermod -aG docker gitlab-runner

  echo "Gitlab runner must be registered manually."
fi

# kubectl
if [ ! -e /usr/local/bin/kubectl ]
then
  echo "Downloading kubectl ..."
  curl -LsO http://storage.googleapis.com/kubernetes-release/release/v1.7.0/bin/linux/amd64/kubectl
  chmod +x kubectl
  mv kubectl /usr/local/bin/
fi

# helm
if [ ! -e /usr/local/bin/helm ]
then
  echo "Downloading helm ..."
  curl -LsO https://storage.googleapis.com/kubernetes-helm/helm-v2.5.0-linux-amd64.tar.gz
  tar zxf helm-v2.5.0-linux-amd64.tar.gz
  chmod +x linux-amd64/helm
  mv linux-amd64/helm /usr/local/bin/
  rm -rf linux-amd64 helm-v2.5.0-linux-amd64.tar.gz
fi


