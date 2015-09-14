tgz_file = "android-sdk_r#{node[:android_sdk_revision]}-linux.tgz"
execute "curl http://dl.google.com/android/#{tgz_file} -o /tmp/#{tgz_file}" do
  user 'android'
  not_if "test -e /tmp/#{tgz_file}"
end

execute "tar zxf /tmp/#{tgz_file} -C /home/android" do
  user 'android'
  not_if 'test -d /home/android/android-sdk-linux'
end

sdk_filter = "platform-tools,android-#{node[:android_api_level]},sys-img-x86-android-#{node[:android_api_level]}"
execute "echo 'y' | /home/android/android-sdk-linux/tools/android update sdk -u -a -t '#{sdk_filter}'" do
  user 'android'
end

execute "echo 'no' | /home/android/android-sdk-linux/tools/android create avd -n #{node[:avd_name]} -t 1 --abi x86" do
  user 'android'
  not_if "/home/android/android-sdk-linux/tools/android list avd | grep '#{node[:avd_name]}'"
end

