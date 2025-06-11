# VM settings
vm_name                     = "Ubuntu24.04.Desktop"
template_name               = "Ubuntu24.04.Desktop"
os                          = "l26"
cores                       = 4
sockets                     = 1
memory                      = 8192
cpu_type                    = "x86-64-v3"
machine                     = "q35"

# Disk
disk_size                   = "8G"
disk_format                 = "raw"
disk_storage_pool           = "local-lvm"
iso_storage_pool            = "local"

# Network
vm_network                  = "vmbr0"
firewall                    = "true"
bridge                      = "vmbr0"

# Path to ISO on Proxmox host
iso_file                    = "local:iso/ubuntu24_04.iso"


#packer build --var-file=ubuntu.pkrvars.hcl --var-file=../.proxmox.pkrvars.hcl ubuntu.pkr.hcl 