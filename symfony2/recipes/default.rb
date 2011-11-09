require_recipe "apt"
require_recipe "apache2"
require_recipe "mysql"
require_recipe "php"
require_recipe "php::module_mysql"
require_recipe "php::module_apc"
require_recipe "php::module_sqlite3"
require_recipe "apache2::mod_php5"

execute "disable-default-site" do
  command "sudo a2dissite default"
  notifies :reload, resources(:service => "apache2"), :delayed
end

web_app "project" do
  template "project.conf.erb"
  notifies :reload, resources(:service => "apache2"), :delayed
end

package "vim" do
  action :install
end

package "php5-intl" do
  action :install
end

template "#{node['php']['conf_dir']}/php.ini" do
  source "symfony.php.ini.erb"
  owner "root"
  group "root"
  mode "0644"
end

template "/etc/php5/apache2/php.ini" do
  source "symfony.php.ini.erb"
  owner "root"
  group "root"
  mode "0644"
end

group "www-data" do
  members "vagrant"
end

