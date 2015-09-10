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

user 'android'
execute 'usermod -G kvm,libvirtd android'

directory '/home/android' do
  owner 'android'
  group 'android'
end

remote_file '/home/android/.bashrc' do
  source '../files/.bashrc'
  owner 'android'
  group 'android'
end

remote_file '/home/android/android-wait-for-emulator' do
  source '../files/android-wait-for-emulator'
  owner 'android'
  group 'android'
  mode '755'
end

tgz_file = 'android-sdk_r24.3.4-linux.tgz'
execute "curl http://dl.google.com/android/#{tgz_file} -o /tmp/#{tgz_file}" do
  user 'android'
  not_if "test -e /tmp/#{tgz_file}"
end

execute "tar zxf /tmp/#{tgz_file} -C /home/android" do
  user 'android'
  not_if 'test -d /home/android/android-sdk-linux'
end

execute 'echo "y" | /home/android/android-sdk-linux/tools/android update sdk -u -a -t "platform-tools,android-23,sys-img-x86-android-23"' do
  user 'android'
end

avd_name = '6.0_x86'
execute "echo 'no' | /home/android/android-sdk-linux/tools/android create avd -n #{avd_name} -t 1 --abi x86" do
  user 'android'
  not_if "/home/android/android-sdk-linux/tools/android list avd | grep '#{avd_name}'"
end

template '/home/android/android-start-emulator' do
  source '../templates/android-start-emulator.erb'
  variables avd_name: avd_name
  owner 'android'
  group 'android'
  mode '755'
end

remote_file '/etc/supervisor/conf.d/android-emulator.conf' do
  source '../files/android-emulator.conf'
end

