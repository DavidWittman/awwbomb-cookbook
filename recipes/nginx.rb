package "nginx" do
  action :install
end

service "nginx" do
  action :nothing
end

template "/etc/nginx/sites-available/default" do
  source "nginx_default.erb"
  owner "root"
  group "root"
  mode "0644"
  notifies :restart, "service[nginx]"
end

include_recipe "awwbomb::thin_upstart"