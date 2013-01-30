maintainer       "David Wittman"
maintainer_email "david@wittman.com"
license          "WTFPL"
description      "Installs/Configures awwbomb"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.3"

depends "firewall"

attribute "awwbomb/username",
  :default => "aww",
  :type => "string"


attribute "awwbomb/port",
  :type => "string",
  :default => "4567"

attribute "awwbomb/cf_username",
  :type => "string",
  :default => "example"

attribute "awwbomb/cf_apikey",
  :type => "string",
  :default => "35d14efa640bb7f8d0073d3cf3a777ff"

attribute "awwbomb/cf_container",
  :type => "string",
  :default => "awwbomb"
