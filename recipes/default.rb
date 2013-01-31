##
# Cookbook Name:: awwbomb
# Recipe:: default
#
# Copyright 2012, David Wittman
#

USERNAME = node[:awwbomb][:username]
HOME = node[:awwbomb][:home]
PROJECT_HOME = node[:awwbomb][:project_home]

if node["awwbomb"]["databag"] != "false"
  data = Chef::EncryptedDataBagItem.load(node["awwbomb"]["databag"], node["awwbomb"]["databag_item"])
  node.set_unless["awwbomb"]["ENV"]["CF_USERNAME"] = data["awwbomb"]["CF_USERNAME"]
  node.set_unless["awwbomb"]["ENV"]["CF_APIKEY"] = data["awwbomb"]["CF_APIKEY"]
  node.set_unless["awwbomb"]["ENV"]["CF_CONTAINER"] = data["awwbomb"]["CF_CONTAINER"]
end

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

user USERNAME do
  comment "#{USERNAME}bomb"
  home HOME
  shell "/bin/bash"
  supports :manage_home => true
end

# Clone repo
git PROJECT_HOME do
  repository node[:awwbomb][:repo]
  reference "master"
  user USERNAME
  group USERNAME
  action :checkout
end

include_recipe "awwbomb::bundler"
include_recipe "awwbomb::passenger"

service "awwbomb" do
  action :start
end
