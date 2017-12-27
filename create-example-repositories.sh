#!/bin/bash
set -eux

source /vagrant/_include_gitlab_api.sh

# import some existing git repositories.
gitlab-create-project-and-import https://github.com/flant/symfony-demo symfony-demo


# configure the git client.
git config --global user.name "Root Doe"
git config --global user.email root@$domain
git config --global push.default simple

