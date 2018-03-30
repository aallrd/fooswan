#!/usr/bin/env bash
# Need to export the startup environment because SSH
# wipes out the environment as part of the login process.
env >> /etc/environment
/usr/sbin/sshd -D
