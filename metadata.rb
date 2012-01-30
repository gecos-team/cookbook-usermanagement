name              "usermanagement"
version           "0.1.4"
maintainer        "Juanje Ojeda"
maintainer_email  "jojeda@emergya.com"
license           "Apache 2.0"
description       "This cookbook provides the ability to change user specific configurations"
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
depends           "ohai-gecos", "~> 1.9.0"

provides          "usermanagement::background"
provides          "usermanagement::shares"
provides          "usermanagement::homepage"
provides          "usermanagement::proxy"
provides          "usermanagement::polkit"
provides          "usermanagement::bookmarks"

recipe            "usermanagement::background", "Desktop background"
recipe            "usermanagement::shares", "Add/remove shares"
recipe            "usermanagement::homepage", "Firefox's homepage"
recipe            "usermanagement::proxy", "Proxy Socks"
recipe            "usermanagement::polkit", "Disable mount usb devices"
recipe            "usermanagement::bookmarks", "Firefox's bookmarks"
recipe            "usermanagement::autostart", "Autostart applications"
recipe            "usermanagement::allowsharing", "Resources sharing permissions"

%w{ ubuntu debian }.each do |os|
  supports os
end

attribute 'autostart/autostart',
  :display_name => "Autostart: Name applications",
  :description  => "List of applications name for autostart",
  :type         => "array",
  :required     => "required",
  :recipes      => [ 'usermanagement::autostart' ]

attribute 'autostart/autostart/name',
  :display_name => "Desktop file name of application",
  :description  => "Set the desktop file name (In e.g gedit.desktop)",
  :type         => "string",
  :order        => "0",
  :recipes      => [ 'usermanagement::autostart' ]


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
  :validation   => "complete_uri",
  :order        => "0",
  :recipes      => [ 'usermanagement::shares' ]

attribute 'shares/shares/action',
  :display_name => "Action",
  :description  => "Action to be performed: add or remove",
  :type         => "string",
  :choice       => [ "add", "remove" ],
  :default      => "add",
  :order        => "1",
  :recipes      => [ 'usermanagement::shares' ]

attribute 'background/name',
  :display_name => "Background name",
  :description  => "Name of the background image file",
  :type         => "string",
  :order        => "0",
  :recipes      => [ 'usermanagement::background' ]

attribute 'background/file_url',
  :display_name => "Background url",
  :description  => "Download image file from this URL",
  :type         => "string",
  :validation   => "url",
  :order        => "1",
  :recipes      => [ 'usermanagement::background' ]

attribute 'homepage/homepage',
  :display_name => "Homepage",
  :description  => "The web page to be set as a Firefox's homepage",
  :type         => "string",
  :validation   => "url",
  :order        => "2",
  :recipes      => [ 'usermanagement::homepage' ]

attribute 'proxy/mode',
  :display_name => "Mode",
  :description  => "Enable (manual mode) or disable the proxy socks",
  :type         => "string",
  :choice       => [ "http", "socks", "none" ],
  :required     => "required",
  :default      => "none",
  :order        => "0",
  :recipes      => [ 'usermanagement::proxy' ]

attribute 'proxy/host',
  :display_name => "Host",
  :description  => "The proxy socks server IP",
  :type         => "string",
  :validation   => "ip",
  :order        => "1",
  :recipes      => [ 'usermanagement::proxy' ]

attribute 'proxy/port',
  :display_name => "Port",
  :description  => "The proxy socks server port",
  :type         => "string",
  :validation   => "integer",
  :order        => "2",
  :recipes      => [ 'usermanagement::proxy' ]

attribute 'polkit/mount',
  :display_name => "Mount",
  :description  => "Can the user access removable devices?",
  :type         => "string",
  :choice       => [ "true", "false" ],
  :default      => "false",
  :order        => "0",
  :recipes      => [ 'usermanagement::polkit' ]


attribute 'bookmarks/bookmarks',
  :display_name => "Bookmarks: List of bookmarks",
  :description  => "List of applications name for autostart",
  :type         => "array",
  :required     => "required",
  :recipes      => [ 'usermanagement::bookmarks' ]

attribute 'bookmarks/bookmarks/title',
  :display_name => "Title",
  :description  => "Bookmark's title",
  :type         => "string",
  :order        => "0",
  :recipes      => [ 'usermanagement::bookmarks' ]

attribute 'bookmarks/bookmarks/url',
  :display_name => "URL",
  :description  => "Bookmark's URL",
  :type         => "string",
  :validation   => "url",
  :order        => "1",
  :recipes      => [ 'usermanagement::bookmarks' ]

attribute 'allowsharing/allowsharing',
  :display_name => "Allow resource sharing",
  :description  => "User can share local resources",
  :type         => "string",
  :choice       => [ "true", "false" ],
  :required     => "required",
  :recipes      => [ 'usermanagement::allowsharing' ]

