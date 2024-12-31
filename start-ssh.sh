#!/bin/bash
set -e

eval $(ssh-agent -s)
ssh-add ~/.ssh/id_rsa
ssh-add -l
