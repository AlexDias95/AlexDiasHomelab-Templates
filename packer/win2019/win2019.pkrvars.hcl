# VM settings
vm_name                     = "Win2019-Template"
template_name               = "Win2019-Template"
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
iso_file                    = "storage:iso/SW_DVD9_Win_Server_STD_CORE_2019_1809.2_64Bit_English_DC_STD_MLF_X22-18452.ISO"


#packer build --var-file=win2019.pkrvars.hcl --var-file=../proxmox.pkrvars.hcl win2019.pkr.hcl 