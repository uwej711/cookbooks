node.set_unless[:proxy][:http] = "http://proxy.burda.com:80/"
node.set_unless[:proxy][:https] = "http://proxy.burda.com:80/"
node.set_unless[:proxy][:pear] = "proxy.burda.com:80"

template "/etc/apt/apt.conf" do
  source "apt.conf.erb"
  owner "root"
  group "root"
  mode "0644"
end

require_recipe "apt"

template "/root/.gemrc" do
  source "gemrc.erb"
  owner "root"
  group "root"
  mode "0644"
end

template "/root/.pearrc" do
  source "pearrc.erb"
  owner "root"
  group "root"
  mode "0644"
end

template "/home/vagrant/.gitconfig" do
  source "gitconfig.erb"
  owner "vagrant"
  group "vagrant"
  mode "0644"
end
