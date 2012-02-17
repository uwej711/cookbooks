require_recipe "apt"
require_recipe "java"

package "curl" do
  action :install
end

template '/etc/init.d/jackrabbit' do
  source 'initscript'
  owner 'root'
  group 'root'
  mode '0755'
end

dir = '/opt/jackrabbit'

if not FileTest::directory?(dir)
  Dir::mkdir(dir)
end

node.set_unless['jackrabbit']['url'] = 'http://ftp-stud.hs-esslingen.de/pub/Mirrors/ftp.apache.org/dist//jackrabbit/2.4.0/jackrabbit-standalone-2.4.0.jar'


if Chef::Config[:http_proxy]
    execute 'jackrabbit' do
      command 'curl --proxy ' + Chef::Config[:http_proxy] + ' ' + node['jackrabbit']['url']  + ' -o /opt/jackrabbit/jackrabbit.jar'
    end 
else
    execute 'jackrabbit' do
      command 'curl ' + node['jackrabbit']['url'] + ' -o /opt/jackrabbit/jackrabbit.jar'
    end 
end
