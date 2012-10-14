##
# Cookbook Name:: awwbomb
# Recipe:: default
#
# Copyright 2012, David Wittman
#

USERNAME = node[:awwbomb][:username]
HOME = node[:awwbomb][:home]
PROJECT_HOME = File.join(HOME, "#{USERNAME}bomb")

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

user USERNAME do
  comment "#{USERNAME}bomb"
  home HOME
  shell "/bin/bash"
  supports :manage_home => true
end

bash "append-to-profile" do
  user USERNAME
  cwd HOME
  code <<-EOH
  echo "#{env_vars}" >> .profile
  EOH
  not_if "grep #{node[:awwbomb][:ENV].keys[0]} .profile", :cwd => HOME
end

# Clone repo and install ruby dependencies
git PROJECT_HOME do
  repository node[:awwbomb][:repo]
  reference "master"
  user USERNAME
  group USERNAME
  action :checkout
end

%w{bundle}.each do |gem|
  gem_package gem do
    action :install
    ignore_failure false
  end
end

# Start Passenger Standalone
bash "start-passenger-standalone" do
  user USERNAME
  cwd PROJECT_HOME
  environment node[:awwbomb][:ENV]
  # There's a bug in Passenger Standalone that requires a 'public' dir
  code "mkdir public && bundle install --deployment && bundle exec passenger start -p #{node[:awwbomb][:port]} -d"
end
