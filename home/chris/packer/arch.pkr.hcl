variable "vbox_cpus" {
  type    = string
  default = "1"
}

variable "vbox_disk_size" {
  type    = string
  default = "4096"
}

variable "vbox_memory" {
  type    = string
  default = "1024"
}

variable "vbox_guest_os_type" {
  type    = string
  default = "ArchLinux_64"
}

variable "vbox_headless" {
  type    = string
  default = "false"
}

variable "vbox_vm_name" {
  type    = string
  default = "packer-arch"
}


variable "iso_checksum" {
  type    = string
  default = "sha256:5934a1561f33a49574ba8bf6dbbdbd18c933470de4e2f7562bec06d24f73839b"
}

variable "iso_url" {
  type    = string
  default = "https://mirror.informatik.tu-freiberg.de/arch/iso/2022.04.05/archlinux-2022.04.05-x86_64.iso"
}


variable "luks_passphrase" {
  type = string
  default = "nonsense"
}


locals {
  ssh_password = "root"
  ssh_username = "root"
}


source "virtualbox-iso" "arch" {

  boot_command = [
    "<wait10>",
    "<enter>",
    "<wait120>",
    "chpasswd <<< ${local.ssh_username}:${local.ssh_password}",
    "<enter>"
  ]

  disk_size            = var.vbox_disk_size
  guest_os_type        = var.vbox_guest_os_type
  hard_drive_interface = "sata"
  headless             = var.vbox_headless
  iso_checksum         = var.iso_checksum
  iso_urls = [ var.iso_url ]
  output_directory     = "output"
  shutdown_command     = "systemctl poweroff"
  ssh_username         = local.ssh_username
  ssh_password         = local.ssh_password
  ssh_wait_timeout     = "10000s"
  firmware = "efi"
  guest_additions_mode = "disable"
  vboxmanage = [
    ["modifyvm", "{{ .Name }}", "--audio", "none"],
    ["modifyvm", "{{ .Name }}", "--usb", "off"],
    ["modifyvm", "{{ .Name }}", "--vram", "12"],
    ["modifyvm", "{{ .Name }}", "--vrde", "off"],
    ["modifyvm", "{{ .Name }}", "--nictype1", "virtio"],
    ["modifyvm", "{{ .Name }}", "--memory", "${var.vbox_memory}"],
    ["modifyvm", "{{ .Name }}", "--cpus", "${var.vbox_cpus}"]
  ]
  virtualbox_version_file = ".vbox_version"
  vm_name                 = var.vbox_vm_name
  format                  = "ova"
}

build {
  sources = ["source.virtualbox-iso.arch"]

  provisioner "shell" {
    # TODO
    environment_vars = [
      "DISK_DEVICE=/dev/sda",
      "DISK_PASSWORD=${var.luks_passphrase}",
      "USER_PASSWORD=${var.luks_passphrase}",
    ]

    scripts = [
      "scripts/partition.sh",
      "scripts/bootstrap.sh",
    ]
  }

  provisioner "file" {
    source = "cmdline"
    destination = "/mnt/etc/kernel/cmdline"
  }

  provisioner "file" {
    source = "mkinitcpio.conf"
    destination = "/mnt/etc/mkinitcpio.conf"
  }

  provisioner "file" {
    source = "linux.preset"
    destination = "/mnt/etc/mkinitcpio.d/linux.preset"
  }

  provisioner "shell" {
    script = "scripts/unified_efi_image.sh"
  }

  provisioner "breakpoint" {
    disable = false
    note    = "this is a breakpoint"
  }

  provisioner "shell" {
    script = "scripts/finalize.sh"
  }
}
