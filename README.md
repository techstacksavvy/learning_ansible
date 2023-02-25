# learning_ansible

Welcome to my RHCE Study and Practice!

<img width="533" alt="image" src="https://user-images.githubusercontent.com/84424434/221372448-fc7b9236-caf0-492d-8e33-72014cea3f93.png">

Ansible is an open-source automation platform that is used to manage and configure both applications and systems. It is built on top of the Python programming language and uses a declarative language called YAML for defining automation workflows. Ansible allows users to define their infrastructure as code and execute it using an agentless architecture.

The Ansible architecture consists of two main components:

1. Control Machine: The control machine is the computer from which the Ansible commands are executed. It can be a local computer or a remote computer.

2. Managed Nodes: These are the target systems or devices that Ansible will manage. These nodes can be physical or virtual machines, as well as network devices, such as routers and switches. The managed nodes must have an SSH server running on them in order for Ansible to connect to them.


<img width="530" alt="image" src="https://user-images.githubusercontent.com/84424434/221372654-6a696a12-8582-4641-83bc-0c8739c60285.png">

Ansible Ad Hoc Commands are commands used to quickly and easily perform tasks on managed nodes. They can be used to perform simple tasks like pinging all of your hosts or more complex tasks like installing and configuring software.

Ansible Plays are the building blocks of Ansible Playbooks. Plays are like individual instructions for a managed node, specifying a particular task and its parameters.

Ansible Playbooks are YAML files that contain instructions for Ansible, written in Plays. They can contain multiple Plays, each of which can specify multiple tasks to be completed. Playbooks can be used to automate complex processes, such as setting up a web server, deploying an application, or configuring a network.
