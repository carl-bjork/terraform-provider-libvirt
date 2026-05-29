# Look up the IP addresses libvirt has observed for a domain's interfaces.
# Addresses come from DHCP leases and/or the QEMU guest agent, so they only
# appear once the guest has booted and acquired an address. Use depends_on or
# a wait so the domain is running before this is read.
data "libvirt_domain_interface_addresses" "vm" {
  domain = libvirt_domain.example.name

  # "lease" reads the dnsmasq DHCP leases (no guest agent required),
  # "agent" queries the QEMU guest agent, "any" (default) tries both.
  source = "lease"
}

# First IPv4 address of the first non-loopback interface.
output "vm_ip" {
  description = "First reported IPv4 address of the domain"
  value = try(
    one([
      for addr in data.libvirt_domain_interface_addresses.vm.interfaces[0].addrs :
      addr.addr if addr.type == "ipv4"
    ]),
    null,
  )
}
