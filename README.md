# Kestra Automation for Proxmox

This repository automates VM template creation, deployment, and cleanup in Proxmox using Kestra, Docker, Packer, and Ansible. Tested on **Ubuntu 24.04** and **CentOS 9**.

## Prerequisites

- A new, clean VM that can connect to your Proxmox server
- Docker and Docker Compose installed on the VM
- Access to Proxmox credentials for API usage
- Download the ISOs for ubuntu 24.04 desktop/server, win10, win2019 aswell quemu_agent.iso on your storage

## Setup Instructions

1. **Clone the Repository**  
   Start by cloning this repository on your VM:
   ```bash
   git clone https://github.com/fansec/proxmox_dev.git
   cd proxmox_dev

2. **Edit Proxmox Creds** 

Update the Proxmox credentials in either of the following files:
- Namespace Configuration (recommended for demo): Modify credentials in the namespace configuration files.
- Direct Configuration: Edit the credentials and values for the storage and node directly in:
    - Packer Configuration (proxmox.pkrvars.hcl)
    - Ansible Variables (vars_node)

3. **Start Docker Services** 

Run Docker Compose to initialize the Kestra environment:
 ``` sudo docker-compose up -d ```

4. **Run the Flows** 

Three flows are available for automating different tasks:
- Template Creation: Builds VM templates for Ubuntu 24.04 (desktop and server), Windows 10 x64, and Windows 2029.
- VM Deployment: Deploys the VMs 4 VMs.
- Cleanup.

## Subfolder Documentation

- [Ansible Role Documentation](./ansible/README.md) - Detailed information about the `ansible` playbooks, including tasks, variables, and handlers.
- [Packer Role Documentation](./packer/README.md) - Detailed information about the `packer` deployments.
- [Kestra Role Documentation](./kestra/README.md) - Detailed information about the `kestra` automation.