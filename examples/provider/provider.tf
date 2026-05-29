terraform {
  required_providers {
    libvirt = {
      source = "dmacvicar/libvirt"
    }
  }
}

# Configure the Libvirt Provider
provider "libvirt" {
  # Connection URI - defaults to qemu:///system if not specified.
  # This maps directly to a libvirt connection URI; see the "Connection
  # Transports" guide for the full list of supported schemes.
  # uri = "qemu:///system"

  # For the per-user session daemon (no root, user-owned VMs):
  # uri = "qemu:///session"

  # Remote host over SSH (Go SSH library):
  # uri = "qemu+ssh://user@remote-host/system"

  # Remote host over TLS:
  # uri = "qemu+tls://remote-host/system"
}
