name              "usermanagement"
version           "0.1.3"
maintainer        "Juanje Ojeda"
maintainer_email  "jojeda@emergya.com"
license           "Apache 2.0"
description       "This cookbook provides the ability to change user specific configurations"
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
depends           "ohai-gecos", "~> 1.9.0"

provides          "usermanagement::background"
provides          "usermanagement::shares"
provides          "usermanagement::homepage"
provides          "usermanagement::proxy_socks"
provides          "usermanagement::polkit"
provides          "usermanagement::bookmarks"

recipe            "usermanagement::background", "Desktop background"
recipe            "usermanagement::shares", "Add/remove shares"
recipe            "usermanagement::homepage", "Firefox's homepage"
recipe            "usermanagement::proxy_socks", "Proxy Socks"
recipe            "usermanagement::polkit", "Disable external DVD and USB devices"
recipe            "usermanagement::bookmarks", "Firefox's bookmarks"

%w{ ubuntu debian }.each do |os|
  supports os
end

attribute 'shares/shares',
  :display_name => "Shares: remote resources",
  :description  => "List of remote shared folders",
  :type         => "array",
  :required     => "required",
  :recipes      => [ 'usermanagement::shares' ]

attribute 'shares/shares/uri',
  :display_name => "Share: remote resource",
  :description  => "Remote resources' URIs in UNIX notation (smb://servername/resource)",
  :type         => "string",
  :required     => "required",
  :validation   => "custom",
  :custom       => "smb|nfs|ftp):\/\/([\S]*)\/.*",
  :recipes      => [ 'usermanagement::shares' ]

attribute 'shares/shares/action',
  :display_name => "Action",
  :description  => "Action to be performed: add or remove",
  :type         => "string",
  :choice       => [ "add", "remove" ],
  :required     => "required",
  :default      => "add",
  :recipes      => [ 'usermanagement::shares' ]

attribute 'background/name',
  :display_name => "Background name",
  :description  => "Name of the background image file",
  :type         => "string",
  :required     => "required",
  :recipes      => [ 'usermanagement::background' ]

attribute 'background/file_url',
  :display_name => "Background url",
  :description  => "Download image file from this URL",
  :type         => "string",
  :required     => "required",
  :validation   => "url",
  :recipes      => [ 'usermanagement::background' ]

attribute 'homepage/homepage',
  :display_name => "Homepage",
  :description  => "The web page to be set as a Firefox's homepage",
  :type         => "string",
  :required     => "required",
  :validation   => "url",
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
  :validation   => "ip",
  :recipes      => [ 'usermanagement::proxy_socks' ]

attribute 'proxy_socks/port',
  :display_name => "Port",
  :description  => "The proxy socks server port",
  :type         => "string",
  :required     => "required",
  :validation   => "integer",
  :recipes      => [ 'usermanagement::proxy_socks' ]

attribute 'polkit/mount',
  :display_name => "Mount",
  :description  => "Can the user access removable devices?",
  :type         => "string",
  :choice       => [ "true", "false" ],
  :required     => "required",
  :default      => "false",
  :recipes      => [ 'usermanagement::polkit' ]

attribute 'bookmarks/title',
  :display_name => "Title",
  :description  => "Bookmark's title",
  :type         => "string",
  :required     => "required",
  :recipes      => [ 'usermanagement::bookmarks' ]

attribute 'bookmarks/url',
  :display_name => "URL",
  :description  => "Bookmark's URL",
  :type         => "string",
  :required     => "required",
  :validation   => "url",
  :recipes      => [ 'usermanagement::bookmarks' ]

