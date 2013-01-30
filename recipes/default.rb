##
# Cookbook Name:: awwbomb
# Recipe:: default
#
# Copyright 2012, David Wittman
#
include_recipe "firewall"

if node["awwbomb"]["databag"] != "false"
  data = Chef::EncryptedDataBagItem.load(node["awwbomb"]["databag"], node["awwbomb"]["databag_item"])
  node.set_unless["awwbomb"]["ENV"]["CF_USERNAME"] = data["awwbomb"]["CF_USERNAME"]
  node.set_unless["awwbomb"]["ENV"]["CF_APIKEY"] = data["awwbomb"]["CF_APIKEY"]
  node.set_unless["awwbomb"]["ENV"]["CF_CONTAINER"] = data["awwbomb"]["CF_CONTAINER"]
end

username = node["awwbomb"]["username"]

execute "apt-get-update" do
  command "apt-get update"
  ignore_failure true
  action :nothing
end.run_action(:run)

node["awwbomb"]["dependencies"].each do |pkg|
  package pkg do
    action :install
  end
end

node.set[:awwbomb][:ENV] = {
  "CF_USERNAME" => node[:awwbomb][:ENV][:CF_USERNAME],
  "CF_APIKEY" => node[:awwbomb][:ENV][:CF_APIKEY],
  "CF_CONTAINER" => node[:awwbomb][:ENV][:CF_CONTAINER]
}

# Add user and export environment variables in their .bashrc
env_vars = ""
node[:awwbomb][:ENV].keys.each do |key|
  env_vars << "\nexport #{key}=#{node[:awwbomb][:ENV][key]}"
end

user username do
  comment "awwbomb"
  home "/home/#{username}"
  shell "/bin/bash"
  supports :manage_home => true
end

bash "append-to-bashrc" do
  user username
  cwd "/home/#{username}"
  code <<-EOH
  echo source .awwbombrc >> .bashrc
  EOH
  not_if "grep .awwbombrc .bashrc", :cwd => "/home/#{username}"
end

template "/home/#{username}/.awwbombrc" do
  source "dot_awwbombrc.erb"
  owner "#{username}"
  group "#{username}"
  mode "0755"
  variables(
    :env_vars => env_vars
  )
end

# Clone repo and install ruby dependencies
git "/home/aww/awwbomb" do
  repository "git://github.com/DavidWittman/awwbomb.git"
  reference "master"
  user username
  group username
  action :checkout
end

%w{bundle passenger patron OptionParser }.each do |gem|
  gem_package gem do
    action :install
    ignore_failure false
  end
end

bash "bundle-install" do
  user "root"
  cwd "/home/#{username}/awwbomb"
  code "bundle install"
end

directory "/home/#{username}/awwbomb/public" do
  owner "#{username}"
  group "#{username}"
  mode "0755"
  action :create
end

# Start Passenger Standalone
bash "start-passenger-standalone" do
  cwd "/home/#{username}/awwbomb"
  code "passenger start -p #{node[:awwbomb][:port]} -d --user=#{username}"
  environment node[:awwbomb][:ENV]
end

firewall_rule "http" do
  port node["awwbomb"]["port"].to_i
  action :allow
end

execute "upload" do
  command <<-EOF
          chmod +x /home/#{username}/awwbomb/upload.rb && \
          ruby /home/#{username}/awwbomb/upload.rb --username #{node["awwbomb"]["ENV"]["CF_USERNAME"]} \
          --apikey #{node["awwbomb"]["ENV"]["CF_APIKEY"]} --container #{node["awwbomb"]["ENV"]["CF_CONTAINER"]}
          EOF
  action :run
end