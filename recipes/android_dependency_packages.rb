execute 'add-apt-repository -y ppa:openjdk-r/ppa'
execute 'apt-get update'

%w(
  qemu-kvm
  libvirt-bin
  ubuntu-vm-builder
  bridge-utils
  openjdk-8-jdk
  libstdc++6:i386
).each do |pkg|
  package pkg
end

