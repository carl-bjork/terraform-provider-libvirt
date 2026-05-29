# Directory pool: the most common pool type. libvirt manages volumes as files
# in a host directory. The directory must already exist (or be created by the
# pool build step) and be accessible to the libvirt daemon.
resource "libvirt_pool" "dir" {
  name = "example-dir"
  type = "dir"

  target = {
    path = "/var/lib/libvirt/images/example"
  }
}

# Logical (LVM) pool: volumes are LVM logical volumes carved out of an existing
# volume group. The volume group named in source.name must already exist on the
# host; libvirt does not create the underlying physical volumes.
resource "libvirt_pool" "logical" {
  name = "example-lvm"
  type = "logical"

  source = {
    name = "vg_libvirt"
  }

  target = {
    path = "/dev/vg_libvirt"
  }
}
