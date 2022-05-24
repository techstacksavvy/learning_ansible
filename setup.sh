#!/bin/bash

ansible all -m yum -a "name=vsftpd state=installed"
ansible all -m service -a "name=vsftpd state=started enabled=yes"
