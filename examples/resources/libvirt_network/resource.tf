# NAT network: guests share the host's connection via libvirt's default
# masquerading rules. libvirt runs a dnsmasq instance bound to the bridge to
# provide DHCP and DNS for the configured subnet.
resource "libvirt_network" "nat" {
  name      = "example-nat"
  autostart = true

  forward = {
    mode = "nat"
  }

  ips = [
    {
      address = "10.17.3.1"
      netmask = "255.255.255.0"

      dhcp = {
        ranges = [
          {
            start = "10.17.3.10"
            end   = "10.17.3.254"
          }
        ]
      }
    }
  ]
}

# Isolated network: no forward block means guests can talk to each other and
# the host, but have no route off-box. libvirt still provides DHCP/DNS on the
# bridge.
resource "libvirt_network" "isolated" {
  name = "example-isolated"

  ips = [
    {
      address = "192.168.100.1"
      netmask = "255.255.255.0"
    }
  ]
}

# Routed network: traffic is routed (not masqueraded) to the physical network.
# The host must be configured to route the guest subnet upstream.
resource "libvirt_network" "routed" {
  name = "example-routed"

  forward = {
    mode = "route"
    dev  = "eth0"
  }

  ips = [
    {
      address = "192.168.150.1"
      prefix  = 24
    }
  ]
}
