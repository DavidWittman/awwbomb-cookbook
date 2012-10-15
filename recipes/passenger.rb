bash "install-passenger-standalone" do
  user node[:awwbomb][:username]
  cwd node[:awwbomb][:project_home]
  code "bundle exec passenger start -d && bundle exec passenger stop"
end

include_recipe "awwbomb::passenger_upstart"
