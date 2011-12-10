name              "usermanagement"
version           "0.1.1"
maintainer        "rcmorano"
maintainer_email  "rcmorano@emergya..com"
license           "Apache 2.0"
description       "This cookbook provides the ability to change user specific configurations"
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))

provides          "usermanagement::background"
provides          "usermanagement::shares"
provides          "usermanagement::homepage"
provides          "usermanagement::proxy_socks"

recipe            "usermanagement::background", "Set user specific desktop background"
recipe            "usermanagement::shares", "Set the remote resource to be mounted"
recipe            "usermanagement::homepage", "Set the Firefox's homepage"
recipe            "usermanagement::proxy_socks", "Enable or unable the Proxy Socks"

%w{ ubuntu debian }.each do |os|
  supports os
end

attribute 'shares/shares',
  :display_name => "Share: remote resource",
  :description  => "The remote resource's URI and the action to be perfomed: add or remove",
  :type         => "array",
  :required     => "required",
  :recipes      => [ 'usermanagement::shares' ]

attribute 'background/name',
  :display_name => "Background name",
  :description  => "Name for the background file",
  :type         => "string",
  :required     => "required",
  :recipes      => [ 'usermanagement::background' ]

attribute 'background/file_url',
  :display_name => "Background url",
  :description  => "URL were the background file is",
  :type         => "string",
  :required     => "required",
  :recipes      => [ 'usermanagement::background' ]

attribute 'homepage/homepage',
  :display_name => "Homepage",
  :description  => "The web page to be set as a Firefox's homepage",
  :type         => "string",
  :required     => "required",
  :recipes      => [ 'usermanagement::homepage' ]

attribute 'proxy_socks/mode',
  :display_name => "Mode",
  :description  => "Enable (manual mode) or disable the proxy socks",
  :type         => "string",
  :choice       => [ "manual", "none" ],
  :required     => "required",
  :default      => "none",
  :recipes      => [ 'usermanagement::proxy_socks' ]

attribute 'proxy_socks/host',
  :display_name => "Host",
  :description  => "The proxy socks server IP",
  :type         => "string",
  :required     => "required",
  :recipes      => [ 'usermanagement::proxy_socks' ]

attribute 'proxy_socks/port',
  :display_name => "Port",
  :description  => "The proxy socks server port",
  :type         => "string",
  :required     => "required",
  :recipes      => [ 'usermanagement::proxy_socks' ]

