# VM settings
vm_name                     = "Win10Pro-Template"
template_name               = "Win10Pro-Template"
os                          = "win10"
cores                       = 2
sockets                     = 2
memory                      = 4112
cpu_type                    = "kvm64"
vm_cdrom_type               = "sata"

# Disk
disk_size                   = "40G"
disk_format                 = "raw"
disk_storage_pool           = "local-lvm"
iso_storage_pool            = "storage"

# Network
vm_network                  = "vmbr0"
firewall                    = "true"
bridge                      = "vmbr0"

# Windows settings
builder_username            = "Administrator"
builder_password            = "P@ssW0rd1!!!"

# Path to Windows 10 ISO on Proxmox host
iso_file                    = "local:iso/Windows-64.iso"


#packer build --var-file=win10x64.pkrvars.hcl --var-file=../proxmox.pkrvars.hcl win10x64.pkr.hcl 