default[:awwbomb] = {
  :server => "nginx",
  :databag => "false",
  :databag_item => "awwbomb",
  :username => "aww",
  :home => "/home/aww",
  :project_home => "/home/aww/awwbomb",
  :dependencies => %w{git-core memcached libcurl4-openssl-dev libssl-dev zlib1g-dev build-essential},
  :repo => "git://github.com/DavidWittman/awwbomb.git",
  :port => 4567,
  :open_ports => ["22", "80"],
  :ENV => {
    "CF_USERNAME" => "example",
    "CF_APIKEY" => "35d14efa640bb7f8d0073d3cf3a777ff",
    "CF_CONTAINER" => "awwbomb",
    "RACK_ENV" => "production"
  }
}
