gem_package "bundle" do
  action :install
  ignore_failure false
end

bash "bundle-install" do
  user node[:awwbomb][:username]
  cwd node[:awwbomb][:project_home]
  code "bundle install --deployment"
end
