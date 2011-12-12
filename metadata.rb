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
provides          "usermanagement::polkit"
provides          "usermanagement::bookmarks"

recipe            "usermanagement::background", "Set user specific desktop background"
recipe            "usermanagement::shares", "Set the remote resource to be mounted"
recipe            "usermanagement::homepage", "Set the Firefox's homepage"
recipe            "usermanagement::proxy_socks", "Enable or unable the Proxy Socks"
recipe            "usermanagement::polkit", "Disable mount device all user with exception if exists"
recipe            "usermanagement::bookmarks", "Set the Firefox's bookmarks"

%w{ ubuntu debian }.each do |os|
  supports os
end

attribute 'shares/shares',
  :display_name => "Share: remote resource",
  :description  => "The remote resources' URIs",
  :type         => "array",
  :required     => "required",
  :recipes      => [ 'usermanagement::shares' ]

attribute 'shares/action',
  :display_name => "Action",
  :description  => "The action to be perfomed: add or remove",
  :type         => "string",
  :choice       => [ "add", "remove" ],
  :required     => "required",
  :default      => "add",
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

attribute 'polkit/mount',
  :display_name => "Munt",
  :description  => "Can the user mount devices?",
  :type         => "string",
  :choice       => [ "true", "false" ],
  :required     => "required",
  :default      => "false",
  :recipes      => [ 'usermanagement::polkit' ]

attribute 'bookmarks/title',
  :display_name => "Title",
  :description  => "The bookmark's title",
  :type         => "string",
  :required     => "required",
  :recipes      => [ 'usermanagement::bookmarks' ]

attribute 'bookmarks/url',
  :display_name => "URL",
  :description  => "The bookmark's URL",
  :type         => "string",
  :required     => "required",
  :recipes      => [ 'usermanagement::bookmarks' ]

