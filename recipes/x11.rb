%w(
  xvfb
  x11vnc
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

