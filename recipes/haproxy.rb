execute 'add-apt-repository -y ppa:vbernat/haproxy-1.5' do
  not_if 'test -e /etc/apt/sources.list.d/vbernat-haproxy-1_5-trusty.list'
  notifies :run, 'execute[apt-get update]', :immediately
end

execute 'apt-get update' do
  action :nothing
end

package 'haproxy'

remote_file '/etc/haproxy/haproxy.cfg' do
  source '../files/haproxy.cfg'
  notifies :reload, 'service[haproxy]'
end

service 'haproxy' do
  action [:start, :enable]
end

