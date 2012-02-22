require_recipe "apache2"
require_recipe "mysql"
require_recipe "mysql::server"
require_recipe "php"
require_recipe "php::module_mysql"
require_recipe "php::module_gd"
require_recipe "apache2::mod_php5"
require_recipe "gems"

execute "disable-default-site" do
  command "sudo a2dissite default"
  notifies :reload, resources(:service => "apache2"), :delayed
end

node.set_unless[:oxid][:port] = "80"

web_app "oxid" do
  template "oxid.conf.erb"
  notifies :reload, resources(:service => "apache2"), :delayed
end

mysql_connection_info = {:host => "localhost", :username => "root", :password => node[:mysql][:server_root_password]}

mysql_database "oxid" do
  connection mysql_connection_info
  action :create
end

mysql_database_user "oxid" do
  connection mysql_connection_info
  password "oxid"
  action :create
end

mysql_database_user "oxid" do
  connection mysql_connection_info
  database_name "oxid"
  action :grant
end
