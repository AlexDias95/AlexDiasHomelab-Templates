# VM settings
vm_name                     = "Win10-Cloudbase"
template_name               = "Win10-Template-Cloudbase"
os                          = "win10"
cores                       = 4
sockets                     = 1
memory                      = 4096
cpu_type                    = "x86-64-v3"
machine                     = "q35"

# Disk
disk_size                   = "30G"
disk_format                 = "qcow2"
disk_storage_pool           = "local-lvm"
iso_storage_pool            = "local"

# Network
vm_network                  = "vmbr0"
firewall                    = "true"
bridge                      = "vmbr0"

# User settings
builder_username            = env("BUILDER_USERNAME")
builder_password            = env("BUILDER_PASSWORD")

# Path to ISO on Proxmox host
iso_file                    = "local:iso/Windows-64.iso"


#packer build --var-file=win10x64.pkrvars.hcl --var-file=../proxmox.pkrvars.hcl win10x64.pkr.hcl 
