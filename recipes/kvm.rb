%w(
  qemu-kvm
  libvirt-bin
  ubuntu-vm-builder
  bridge-utils
).each do |pkg|
  package pkg
end
