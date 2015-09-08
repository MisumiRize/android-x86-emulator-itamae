user 'android'
execute 'usermod -G kvm android'
execute 'usermod -G libvirtd android'

directory '/home/android' do
  owner 'android'
  group 'android'
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
