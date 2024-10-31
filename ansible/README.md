# Ansible VM Deployment and Configuration

This is the skeleton used for future project. This repository contains a set of Ansible playbooks and roles designed for the dynamic creation, deletion, and management of Windows and Linux virtual machines (VMs) using Proxmox VE. The VMs are created from pre-existing templates, assigned dynamic IPs via DHCP, and automatically added to a static inventory file (`hosts`) for future provisioning and configuration. There are 3 playbooks avaible run with ansible-playbook playbooks/.

## Features

- **Cross-Platform Support:**  
  The setup supports both Windows and Linux VMs, ensuring a consistent deployment process across different environments.

- **Dynamic Inventory Management:**  
  The IP addresses of the deployed VMs are dynamically assigned via DHCP and automatically populated into the `hosts` inventory file. This makes future provisioning tasks straightforward and automated.

- **Template-Based VM Creation:**  
  VMs are created from existing templates made with Packer, allowing for a quick and standardized setup.

- **Flexible Role Structure:**  
  The roles are organized to allow for easy expansion and customization, accommodating different deployment scenarios.

## Directory Structure

```
ansible/
│
├── playbooks/
│   ├── config_windows.yaml        # Playbook to configure Windows VMs
│   ├── delete_hosts.yaml          # Playbook to delete VMs and remove them from the inventory
│   └── deploy_hosts.yaml          # Playbook to deploy new VMs and update the inventory
│
├── roles/
│   ├── configure/
│   │   └── windows/
│   │       └── test/
│   │           └── tasks/
│   │               └── main.yaml  # Tasks to configure Windows VMs
│   │
│   ├── delete/
│   │   └── all/
│   │       └── tasks/
│   │           └── main.yaml      # Tasks to delete VMs
│   │
│   └── deploy/
│       ├── linux/
│       │   └── tasks/
│       │       └── main.yaml      # Tasks to deploy Linux VMs
│       └── windows/
│           └── tasks/
│               └── main.yaml      # Tasks to deploy Windows VMs
│
├── vars/
│   ├── vars_configure.yaml        # Variables for configuring VMs
│   ├── vars_deploy.yaml           # Variables for deploying VMs
│   └── vars_hosts.yaml            # Variables for managing the hosts file
│
├── hosts                          # Static inventory file updated dynamically with VM details
└── README.md                      # This README file
```

## How It Works

### 1. Deployment of VMs

**Playbook:** `deploy_hosts.yaml`  
This playbook is used to create VMs from existing templates. Both Linux and Windows VMs are deployed as specified in the `newid_values` and `newid_values_win` lists. Each VM is assigned an IP address via DHCP, which is then retrieved and added to the `hosts` inventory file.

### 2. Configuration of VMs

**Playbook:** `config_windows.yaml`  
After deployment, Windows VMs can be further configured using this playbook. The configuration is performed by roles specified under `roles/configure/windows/test`. 

### 3. Deletion of VMs

**Playbook:** `delete_hosts.yaml`  
This playbook deletes existing VMs and removes their entries from the `hosts` inventory file, ensuring that the inventory remains accurate and up-to-date.

### 4. Inventory Management

**Inventory File:** `hosts`  
The `hosts` file acts as a static inventory that is dynamically updated with the IP addresses and hostnames of the deployed VMs. This setup simplifies future provisioning tasks, as the VMs can be referenced by their hostnames or vmid.



## Requirements
Ansible 
Proxmox VE 
Pre-existing VM templates on Proxmox

## License
This project is licensed under the MIT License.


## Encountered Issues
```
ansible-galaxy collection install community.general --upgrade
```