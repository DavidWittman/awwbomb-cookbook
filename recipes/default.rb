##
# Cookbook Name:: awwbomb
# Recipe:: default
#
# Copyright 2012, David Wittman
#

username = node[:awwbomb][:username]

execute "apt-get-update" do
  command "apt-get update"
  ignore_failure true
  action :nothing
end.run_action(:run)

node[:awwbomb][:dependencies].each do |pkg|
  package pkg do
    action :install
  end
end

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
  echo "#{env_vars}" >> .bashrc
  EOH
  not_if "grep #{node[:awwbomb][:ENV].keys[0]} .bashrc", :cwd => "/home/#{username}"
end

# Clone repo and install ruby dependencies
git "/home/aww/awwbomb" do
  repository "git://github.com/DavidWittman/awwbomb.git"
  reference "master"
  user username
  group username
  action :checkout
end

%w{bundle passenger}.each do |gem|
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

# Start Passenger Standalone
bash "start-passenger-standalone" do
  user username
  cwd "/home/#{username}/awwbomb"
  # There's a bug in Passenger Standalone that requires a 'public' dir
  code "mkdir public && passenger start -p #{node[:awwbomb][:port]} -d"
end
