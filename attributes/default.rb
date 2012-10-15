default[:awwbomb][:username] = "aww"
default[:awwbomb][:home] = "/home/aww"
default[:awwbomb][:project_home] = "/home/aww/awwbomb"
default[:awwbomb][:dependencies] = %w{git-core memcached libcurl4-openssl-dev libssl-dev zlib1g-dev build-essential}
default[:awwbomb][:repo] = "git://github.com/DavidWittman/awwbomb.git"
default[:awwbomb][:port] = 4567
default[:awwbomb][:ENV] = {
  "CF_USERNAME" => "example",
  "CF_APIKEY" => "35d14efa640bb7f8d0073d3cf3a777ff",
  "CF_CONTAINER" => "awwbomb",
  "RACK_ENV" => "production"
}
