#!/bin/sh
ansible-playbook \
    playbooks/localhost.yml \
    -i inventries/hosts \
    --ask-become-pass
