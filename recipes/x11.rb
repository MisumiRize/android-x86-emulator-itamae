%w(
  xvfb
  lxde
  x11vnc
  supervisor
  xinetd
).each do |pkg|
  package pkg
end

#remote_file '/etc/xinetd.d/x11vnc' do
#  source '../files/x11vnc'
#end
#
#service 'xinetd' do
#  action [:start, :enable]
#end

remote_file '/etc/supervisor/conf.d/xvfb.conf' do
  source '../files/xvfb.conf'
end

service 'supervisor' do
  action [:start, :enable]
end

