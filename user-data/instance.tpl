#!/bin/bash

amazon-linux-extras install nginx1 -y
echo `hostname -f` > /usr/share/nginx/html/index.html
systemctl enable --now nginx