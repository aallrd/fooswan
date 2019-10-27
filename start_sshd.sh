#!/usr/bin/env bash
# Need to export the startup environment because SSH
# wipes out the environment as part of the login process.
env | sudo tee -a /etc/environment >/dev/null
sudo /usr/sbin/sshd -D
