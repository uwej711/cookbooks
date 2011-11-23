template "/etc/apt/apt.conf" do
  source "apt.conf.erb"
  owner "root"
  group "root"
  mode "0644"
end

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


