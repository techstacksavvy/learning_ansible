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
```
---
- hosts: dbsystems
  become: yes
  tasks:
    - name: Create "consultant" user
      user:
        name: consultant
```

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

**Ansible Playbooks(the basics)**
---
The contents of my inventory file...

```
[web]
node1
node2
```
The contents of my playbook...
There are four tasks included in this playbook. This playbook is used to install and enable the Apache web server on a group of hosts called 'web'. The first task uses the yum module to install the latest version of Apache. The second task starts and enables the Apache service. The third task uses the get_url module to download a tar file from a repository and save it to the /tmp directory. The final task uses the remote_src module to unarchive the tar file in the /var/www/html directory.

```
---
- hosts: web
  become: yes
  tasks:
    - name: install httpd
      yum:
        name: httpd
        state: latest

    - name: start and enable httpd on web group
      service:
        name: httpd
        state: started
        enabled: yes

    - name: retrieve website from repo
      get_url:
        url: http://repo.example.com/website.tgz
        dest: /tmp/website.tgz

    - name: install website
      unarchive:
        remote_src: yes
        src: /tmp/website.tgz
        dest: /var/www/html/
        
 ```
<img width="766" alt="image" src="https://user-images.githubusercontent.com/84424434/222996963-56894da6-2e9e-419b-a15f-8e7abd4a3d2e.png">

The **get_url module** is used to download files from a remote URL and save them locally. It can be used to download archives, configuration files, scripts, and other types of files. It supports downloading files over FTP, HTTP, and HTTPS protocols.

The **remote_src module** is used to copy files from a remote server to the local machine. It supports copying files from a variety of protocols including SCP, FTP, and HTTP. It can also be used to download files from a remote URL and unarchive them.

Error Handling
---

**The Assignment:**

We have to set up automation to pull down a data file, from a notoriously unreliable third-party system, for integration purposes. Create a playbook that attempts to pull down http://apps.l33t.com/transaction_list to localhost. The playbook should gracefully handle the site being down by outputting the message "l33t.com appears to be down. Try again later." to stdout. If the task succeeds, the playbook should write "File downloaded." to stdout. No matter if the playbook errors or not, it should always output "Attempt completed." to stdout. If the report is collected, the playbook should write and edit the file to replace all occurrences of #BLANKLINE with a line break \n. 

Credit: A Cloud Guru

<img width="656" alt="image" src="https://user-images.githubusercontent.com/84424434/223316978-728b1ec0-17f1-497e-bdd4-cc4ab434f3fd.png">

<img width="458" alt="image" src="https://user-images.githubusercontent.com/84424434/223316885-1c29c272-4a72-4686-8479-c4a7b07d80b5.png">

**Time to investigate this FAILED replace task**

<img width="945" alt="image" src="https://user-images.githubusercontent.com/84424434/223317514-a270c400-c470-42b3-bd5f-5cf8bd190e59.png">

**Typo**...regex should've been regexp

<img width="342" alt="image" src="https://user-images.githubusercontent.com/84424434/223319334-2e7f8996-74c5-4b0a-b55e-6236b79de227.png">

Error free playbook...

```
---
- hosts: localhost
  become: yes
  tasks:
    - name: download transaction list to localhost
      block:
        - get_url:
            url: http://apps.l33t.com/transaction_list
            dest: /home/ansible/transaction_list
        - replace:
            path: /home/ansible/transaction_list
            regexp: "#BLANKLINE"
            replace: '\n'
        - debug:
            msg: "File Downloaded"
      rescue:  
        -debug:
           msg: "l33t.com appears to be down. Try again later."
        -debug:
           msg: "Attempt Completed."
```

SUCCESS!

<img width="761" alt="image" src="https://user-images.githubusercontent.com/84424434/223319081-74e24d3a-c920-44d7-b7e4-838a2d2d4a9f.png">

Terms & Explanations (cont.)
---

Ansible uses two keywords, **block, and rescue**, to help manage error handling within a play. **Blocks** allow multiple tasks to be grouped together and executed as a single unit. If any task within the block fails, the entire block will fail. 

**Rescues** allow the execution of tasks that will only run if a task within a block fails. This allows for tasks to be run that may help correct the issue that caused the block to fail, allowing for automated remediation of certain issues.

The **debug module** in Ansible allows the user to print out variables or other information to the terminal for debugging purposes. It can be used to print out the content of a variable or the results of a task. 

The **replace module** is used to search and replace text within a file. It can be used to change settings or values within configuration files. It also allows for regular expressions to be used to search and replace.

Ansible uses **regular expressions (regex)** to match strings, characters, and patterns within tasks and playbooks. Regex is a powerful tool for performing complex matches and substitutions on strings. It is often used to match words, and phrases, or to extract data from text. Regex can be used in combination with other modules to search and replace text within a file. 

**Regular expressions** are composed of characters and special operators that can match certain patterns of characters. For example, a regex may be used to match the word "ansible" in a string of text. Regex can also be used to match multiple words, or to match words in a specific order. Regular expressions can also be used to extract specific information from a string, such as an email address or a phone number.
