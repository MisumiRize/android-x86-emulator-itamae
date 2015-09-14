package 'supervisor'

%w(
  android-emulator
  adb-server
  xvfb
).each do |conf|
  remote_file "/etc/supervisor/conf.d/#{conf}.conf" do
    source "../files/#{conf}.conf"
    notifies :restart, 'service[supervisor]'
  end
end

service 'supervisor' do
  action [:start, :enable]
end

