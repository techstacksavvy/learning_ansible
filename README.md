# learning_ansible

Welcome to my RHCE Study and Practice!

<img width="533" alt="image" src="https://user-images.githubusercontent.com/84424434/221372448-fc7b9236-caf0-492d-8e33-72014cea3f93.png">

**Ansible** is an open-source automation platform that is used to manage and configure both applications and systems. It is built on top of the Python programming language and uses a declarative language called YAML for defining automation workflows. Ansible allows users to define their infrastructure as code and execute it using an agentless architecture.

The **Ansible architecture** consists of two main components:

1. **Control Machine:** The control machine is the computer from which the Ansible commands are executed. It can be a local computer or a remote computer.

2. **Managed Nodes:** These are the target systems or devices that Ansible will manage. These nodes can be physical or virtual machines, as well as network devices, such as routers and switches. The managed nodes must have an SSH server running on them in order for Ansible to connect to them.


<img width="530" alt="image" src="https://user-images.githubusercontent.com/84424434/221372654-6a696a12-8582-4641-83bc-0c8739c60285.png">

**Ansible Ad Hoc Commands** are commands used to quickly and easily perform tasks on managed nodes. They can be used to perform simple tasks like pinging all of your hosts or more complex tasks like installing and configuring software.

**Ansible Plays** are the building blocks of Ansible Playbooks. Plays are like individual instructions for a managed node, specifying a particular task and its parameters.

**Ansible Playbooks** are YAML files that contain instructions for Ansible, written in Plays. They can contain multiple Plays, each of which can specify multiple tasks to be completed. Playbooks can be used to automate complex processes, such as setting up a web server, deploying an application, or configuring a network.

**ad-hoc cmd**
```ansible dbsystems -b -m user -a "name=consultant"```

This command will use the Ansible tool to create a user named "consultant" on all servers in the "dbsystems" inventory group. The -b flag indicates that the command should be run as the "root" user, while the -m flag specifies the module to use (in this case, the "user" module). The -a flag is used to provide the module's arguments, which in this case is the name of the user to be created.

**written as a play...**

<html>
  <body>
    <pre>
      ---
      - hosts: dbsystems
        become: yes
        tasks:
          - name: Create "consultant" user
            user:
              name: consultant
    </pre>
  </body>
</html>


**user module**

The user module is used in Ansible to manage user accounts on remote systems. It can be used to create, delete, modify, and manage users and their associated settings, such as passwords, groups, and other privileges. It can also be used to manage SSH keys, sudo access, and other user-specific settings. The user module is very powerful and can be used to quickly and easily manage user accounts on remote systems.

**file module**

The file module is used in Ansible to manage files and directories. It can be used to create, delete, modify, and move files and directories, as well as set permissions and ownership. It can also be used to copy and synchronize files and directories between different locations, such as between servers and local machines. The file module is very flexible and allows for a wide range of functionality.

```ansible dbsystems -b -m file -a "path=/home/consultant/.ssh state=directory owner=consultant group=consultant mode=0755"```

This command will use the Ansible tool to create a directory called ".ssh" in the home directory of the user "consultant" on all servers in the "dbsystems" inventory group. The -b flag indicates that the command should be run as the "root" user, while the -m flag specifies the module to use (in this case, the "file" module). The -a flag is used to provide the module's arguments, which in this case is the path of the directory to be created, the owner and group to set for the directory, and the permissions to set for the directory (mode=0755).

**ad-hoc cmd**

```ansible dbsystems -b -m copy -a "src=/home/ansible/keys/consultant/authorized_keys dest=/home/consultant/.ssh/authorized_keys mode=0600 owner=consultant group=consultant"```

**written as a play...**
```
---
- hosts: dbsystems
  become: yes
  tasks:
    - name: Create Consultant SSH Key
      copy:
        src: /home/ansible/keys/consultant/authorized_keys
        dest: /home/consultant/.ssh/authorized_keys
        mode: 0600
        owner: consultant
        group: consultant
```
**service module**

The service module is used in Ansible to manage services on remote systems. It can be used to start, stop, restart, and reload services, as well as check the status of a service to ensure it is running. It can also be used to enable or disable services to ensure they start at boot time. The service module is very useful for quickly and easily managing services on remote systems.


```ansible all -b -m service -a "name=auditd state=started enabled=yes"```

This command will use the Ansible tool to start the "auditd" service on all servers in the inventory. The -b flag indicates that the command should be run as the "root" user, while the -m flag specifies the module to use (in this case, the "service" module). The -a flag is used to provide the module's arguments, which in this case is the name of the service to be managed, the desired state (started), and whether the service should be enabled or disabled (enabled=yes).

what are the different **states in ansible**?

- present
- absent
- started
- stopped
- restarted
- reloaded
- enabled
- disabled

**The "present" and "absent" states are used for managing files, directories, and packages; 
The "started", "stopped", "restarted", and "reloaded" states are used for managing services; 
The "enabled" and "disabled" states are used for ensuring services are started at boot time.**

**ad-hoc cmd**

```ansible all -b -m service -a "name=auditd state=started enabled=yes"```

**written as a play**
```
---
- hosts: all
  become: yes
  tasks:
    - name: Start auditd service
      service:
        name: auditd
        state: started
        enabled: yes
```
what is **auditd**?

**technical definition:**
**Auditd** is an auditing service that is used to log system events on Linux systems. It logs system calls, user logins, user actions, and other system events that can be used for security and troubleshooting purposes. Auditd can be configured to log different types of events and to log to different destinations, such as a file, a syslog server, or a remote server.

**in layman's terms:**
**Auditd** is a computer program that helps to keep your computer safe. It keeps track of what people do on your computer, like what files they open or what changes they make. It also keeps a record of what programs are running and when they are running. This helps to make sure that only people who are allowed to use your computer can access it, and that no one is doing anything to make your computer less secure.

configure media Host Group to Contain media1 and media2
```
[media]
media1
media2
```
Define variables
media_content should be set to /tmp/var/media/content/
```
media:
  media_content: /tmp/var/media/content/
```
where are variables defined in ansible?

**Variables in Ansible** are defined in the playbook itself, or in an external file such as a configuration file, inventory file, or group variables file. They can also be defined from the command line with the "-e" or "--extra-vars" flag.

example:
```
[media]
media1
media2
media_content=/tmp/var/media/content/
```
variables can also be put into it's own dir
**for example:**
```
mkdir group_vars
vim group_vars/media
[in the file write] media_content: /tmp/var/media/content/
```
