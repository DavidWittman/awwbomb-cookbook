%w{patron OptionParser cloudfiles}.each do |gem|
  gem_package gem do
    action :install
    ignore_failure false
  end
end

execute "upload" do
  environment ({'PATH' => '/opt/chef/embedded/bin:/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
                'GEM_PATH' => '/opt/chef/embedded/lib/ruby/gems/1.9.1/gems/'})
  command <<-EOF
          chmod +x #{node[:awwbomb][:project_home]}/upload.rb && \
          ruby #{node[:awwbomb][:project_home]}/upload.rb --username #{node["awwbomb"]["ENV"]["CF_USERNAME"]} \
          --apikey #{node["awwbomb"]["ENV"]["CF_APIKEY"]} --container #{node["awwbomb"]["ENV"]["CF_CONTAINER"]} \
          && touch #{node[:awwbomb][:home]}/uploaded
          EOF
  action :run
  not_if "test -f #{node[:awwbomb][:home]}/uploaded"
end
