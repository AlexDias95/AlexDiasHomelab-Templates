# VM settings
vm_name                     = "Win2019-Template"
template_name               = "Win2019-Template-Cloudbase"
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

# Path to ISO on Proxmox host
iso_file                    = "local:iso/en_windows_server_2019_updated_sept_2019_x64_dvd_199664ce.iso"


#packer build --var-file=win2019.pkrvars.hcl --var-file=../proxmox.pkrvars.hcl win2019.pkr.hcl 