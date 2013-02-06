%w{patron cloudfiles}.each do |gem|
  chef_gem gem do
    action :install
    ignore_failure false
  end
end

require 'cloudfiles'
require 'json'
require 'patron'
require 'uri'

class Chef::Recipe
  include UploadToCloudfiles
end

upload(node["awwbomb"]["ENV"]["CF_USERNAME"], node["awwbomb"]["ENV"]["CF_APIKEY"],
       node["awwbomb"]["ENV"]["CF_CONTAINER"])