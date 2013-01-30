default[:awwbomb][:databag] = "false"
default[:awwbomb][:databag_item] = "awwbomb"
default[:awwbomb][:username] = "aww"
default[:awwbomb][:dependencies] = %w{git-core memcached libcurl4-openssl-dev libssl-dev zlib1g-dev build-essential}
default[:awwbomb][:port] = 4567
default[:awwbomb][:ENV][:CF_USERNAME] = "example"
default[:awwbomb][:ENV][:CF_APIKEY] = "35d14efa640bb7f8d0073d3cf3a777ff"
default[:awwbomb][:ENV][:CF_CONTAINER] = "awwbomb" 
