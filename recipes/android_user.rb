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

template '/home/android/android-start-emulator' do
  source '../templates/android-start-emulator.erb'
  owner 'android'
  group 'android'
  mode '755'
end

