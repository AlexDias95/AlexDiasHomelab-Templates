packer {
  required_version = ">= 1.11.0"

  required_plugins {
    proxmox = {
      version = "= 1.2.1"
      source  = "github.com/hashicorp/proxmox"
    }
  }
}

variable "proxmox_host" {
  type        = string
  description = "Proxmox Server IP Address or Hostname"
  default     = ""
}

variable "proxmox_api_user" {
  type        = string
  description = "Proxmox Username"
  default     = ""
}

variable "proxmox_api_password" {
  type        = string
  description = "Proxmox Password"
  default     = ""
  sensitive   = true
}

variable "vm_name" {
  type        = string
  description = "Name of VM Template"
  default     = ""
}

variable "template_name" {
  type        = string
  description = "Name of the template. Defaults to the generated name used during creation"
}

variable "iso_storage_pool" {
  type        = string
  description = "Proxmox storage pool onto which to upload the ISO file."
}

variable "iso_file" {
  type        = string
  description = "Path to Windows ISO"
  default     = ""
}

variable "os" {
  type        = string
  description = "VM Guest OS Type"
  default     = ""
}

variable "cores" {
  type        = string
  description = " How many CPU cores to give the virtual machine. Defaults to 1"
}

variable "cpu_type" {
  type        = string
  description = "The CPU type to emulate. See the Proxmox API documentation for the complete list of accepted values. For best performance, set this to host. Defaults to x86-64-v3"
}

variable "sockets" {
  type        = string
  description = "How many CPU sockets to give the virtual machine. Defaults to 1"
}

variable "memory" {
  type        = string
  description = "Amount of RAM for VM"
}


variable "proxmox_node" {
  type    = string
  default = ""
}

variable "proxmox_password" {
  type    = string
  default = ""
}

variable "proxmox_storage_format" {
  type    = string
  default = "raw"
}

variable "proxmox_url" {
  type    = string
  default = ""
}

variable "proxmox_username" {
  type    = string
  default = ""
}

variable "template_description" {
  type    = string
  default = "Ubuntu Server 22.04 Template"
}

variable "builder_username" {
  type        = string
  description = "VM Guest Username to Build With"
  default     = ""
}

variable "builder_password" {
  type        = string
  description = "VM Guest User's Password to Authenticate With"
  default     = ""
}

variable "disk_format" {
  type    = string
  description = "The format of the file backing the disk. Can be raw, cow, qcow, qed, raw, vmdk or cloop. Defaults to raw"
  default = ""
}

variable "disk_size" {
  type        = string
  description = "The size of the disk, including a unit suffix, such as 10G to indicate 10 gigabytes."
}

variable "disk_storage_pool" {
  type    = string
  description = "Name of the Proxmox storage pool to store the virtual machine disk on"
}

variable "version" {
  type    = string
  default = ""
}

variable "firewall" {
  type        = string
  description = "If the interface should be protected by the firewall. Defaults to false"
}

variable "machine" {
  type        = string
  description = "The machine type to emulate. Defaults to pc, but can also be q35"
}

source "proxmox-iso" "ubuntu" {
  
  #cd_files = ["cloud-init"]
  #cd_content = [ "data/meta-data", "data/user-data" ]
  #cd_label = "cidata"

  boot_command = [
    "c<wait>",
    "linux /casper/vmlinuz",
    " net.ifnames=0",
    " autoinstall",
    "<enter><wait5s>",
    "initrd /casper/initrd",
    "<enter><wait5s>",
    "boot",
    "<enter><wait5s>",
  ]

  
  boot_wait    = "5s"
 
  # VM Cloud-Init Settings
  cloud_init = true
  cloud_init_storage_pool = var.disk_storage_pool

  vm_name                  = var.vm_name
  vm_id                    = "20001" 

  qemu_agent = true
  
  additional_iso_files {
          unmount          = true
          device           = "ide3"
          iso_storage_pool = var.iso_storage_pool
          cd_files = [ "data/meta-data", "data/user-data" ]
          cd_label = "cidata"
    }

  disks {
    disk_size         = var.disk_size
    format            = var.disk_format
    storage_pool      = var.disk_storage_pool
    type              = "virtio"
  }
  iso_file                 = var.iso_file
  
  network_adapters {
        model = "virtio"
        bridge = "vmbr0"
        firewall = var.firewall
    }

  sockets                  = var.sockets
  cores                    = var.cores
  cpu_type                 = var.cpu_type
  node                 = var.proxmox_node
  proxmox_url          = "https://${var.proxmox_host}/api2/json"
  username             = var.proxmox_api_user
  password             = var.proxmox_api_password
  insecure_skip_tls_verify = true
  memory               = var.memory
  os                   = var.os
  machine              = var.machine
  scsi_controller      = "virtio-scsi-single"
  ssh_password         = var.builder_password
  ssh_port             = 22
  ssh_timeout          = "60m"
  ssh_username         = var.builder_username
  template_description = var.template_description
  unmount_iso          = true
}

build {
  sources = ["source.proxmox-iso.ubuntu"]

  provisioner "shell" {
    inline = ["while [ ! -f /var/lib/cloud/instance/boot-finished ]; do echo 'Waiting for cloud-init...'; sleep 1; done",
              "sudo rm -f /etc/cloud/cloud.cfg.d/99-installer.cfg",
              "sudo cloud-init clean",
              "sudo rm /etc/ssh/ssh_host_*",
              "sudo truncate -s 0 /etc/machine-id",
              "sudo apt -y autoremove --purge",
              "sudo apt -y clean",
              "sudo apt -y autoclean",
              "sudo rm -f /etc/cloud/cloud.cfg.d/subiquity-disable-cloudinit-networking.cfg",
              "sudo sync"
              ]
  }

 }


