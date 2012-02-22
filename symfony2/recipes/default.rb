require_recipe "apt"
require_recipe "apache2"
require_recipe "mysql"
require_recipe "mysql::server"
require_recipe "php"
require_recipe "php::module_mysql"
require_recipe "php::module_apc"
require_recipe "php::module_sqlite3"
require_recipe "php::mopule_curl"
require_recipe "apache2::mod_php5"
require_recipe "gems"

execute "disable-default-site" do
  command "sudo a2dissite default"
  notifies :reload, resources(:service => "apache2"), :delayed
end

node.set_unless[:symfony][:port] = "80"

web_app "symfony" do
  template "symfony.conf.erb"
  notifies :reload, resources(:service => "apache2"), :delayed
end

package "git" do
  action :install
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

package "build-essential" do
  action :install
end

gem_package "mysql" do
  action :install
end

mysql_connection_info = {:host => "localhost", :username => "root", :password => node[:mysql][:server_root_password]}

mysql_database "symfony" do
  connection mysql_connection_info
  action :create
end

mysql_database_user "symfony" do
  connection mysql_connection_info
  password "symfony"
  action :create
end

mysql_database_user "symfony" do
  connection mysql_connection_info
  database_name "symfony"
  action :grant
end
