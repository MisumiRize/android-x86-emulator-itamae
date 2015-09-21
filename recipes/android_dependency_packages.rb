execute 'add-apt-repository -y ppa:openjdk-r/ppa' do
  not_if 'test -e /etc/apt/sources.list.d/openjdk-r-ppa-trusty.list'
  notifies :run, 'execute[apt-get update]', :immediately
end

execute 'apt-get update' do
  action :nothing
end

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

