name              "usermanagement"
version           "0.1.4"
maintainer        "Juanje Ojeda"
maintainer_email  "jojeda@emergya.com"
license           "Apache 2.0"
description       "This cookbook provides the ability to change user specific configurations"
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
depends           "ohai-gecos", "~> 1.9.0"

provides          "usermanagement::background"
provides          "usermanagement::network_folders"
provides          "usermanagement::web_start_page"
provides          "usermanagement::proxy"
provides          "usermanagement::external_units"
provides          "usermanagement::web_bookmarks"
provides          "usermanagement::autostart"
provides          "usermanagement::resource_sharing"

recipe            "usermanagement::background", "Desktop background"
recipe            "usermanagement::network_folders", "Add/remove shares"
recipe            "usermanagement::web_start_page", "Firefox's homepage"
recipe            "usermanagement::proxy", "Proxy Socks"
recipe            "usermanagement::external_units", "Disable mount usb devices"
recipe            "usermanagement::web_bookmarks", "Firefox's bookmarks"
recipe            "usermanagement::autostart", "Autostart applications"
recipe            "usermanagement::resource_sharing", "Resources sharing permissions"

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


attribute 'network_folders/network_folders',
  :display_name => "Shares: remote resources",
  :description  => "List of remote shared folders",
  :type         => "array",
  :required     => "required",
  :recipes      => [ 'usermanagement::network_folders' ]

attribute 'network_folders/network_folders/uri',
  :display_name => "Share: remote resource",
  :description  => "Remote resources' URIs in UNIX notation (smb://servername/resource)",
  :type         => "string",
  :validation   => "complete_uri",
  :order        => "0",
  :recipes      => [ 'usermanagement::network_folders' ]

attribute 'network_folders/network_folders/action',
  :display_name => "Action",
  :description  => "Action to be performed: add or remove",
  :type         => "string",
  :choice       => [ "add", "remove" ],
  :default      => "add",
  :order        => "1",
  :recipes      => [ 'usermanagement::network_folders' ]

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

attribute 'web_start_page/web_start_page',
  :display_name => "Homepage",
  :description  => "The web page to be set as a Firefox's homepage",
  :type         => "string",
  :validation   => "url",
  :order        => "2",
  :recipes      => [ 'usermanagement::web_start_page' ]

attribute 'proxy/mode',
  :display_name => "Mode",
  :description  => "Enable (manual mode) or disable the proxy",
  :type         => "string",
  :choice       => [ "manual", "none" ],
  :required     => "required",
  :default      => "none",
  :order        => "0",
  :recipes      => [ 'usermanagement::proxy' ]

attribute 'proxy/host_http',
  :display_name => "Host (HTTP)",
  :description  => "The proxy http server IP",
  :type         => "string",
  :validation   => "ip",
  :order        => "1",
  :recipes      => [ 'usermanagement::proxy' ]

attribute 'proxy/port_http',
  :display_name => "Port (HTTP)",
  :description  => "The proxy http server port",
  :type         => "string",
  :validation   => "integer",
  :order        => "2",
  :recipes      => [ 'usermanagement::proxy' ]

attribute 'proxy/host_socks',
  :display_name => "Host (SOCKS)",
  :description  => "The proxy socks server IP",
  :type         => "string",
  :validation   => "ip",
  :order        => "3",
  :recipes      => [ 'usermanagement::proxy' ]

attribute 'proxy/port_socks',
  :display_name => "Port (SOCKS)",
  :description  => "The proxy socks server port",
  :type         => "string",
  :validation   => "integer",
  :order        => "4",
  :recipes      => [ 'usermanagement::proxy' ]

attribute 'external_units/mount',
  :display_name => "Mount",
  :description  => "Can the user access removable devices?",
  :type         => "string",
  :choice       => [ "true", "false" ],
  :default      => "false",
  :order        => "0",
  :recipes      => [ 'usermanagement::external_units' ]


attribute 'web_bookmarks/web_bookmarks',
  :display_name => "Bookmarks: List of bookmarks",
  :description  => "List of applications name for autostart",
  :type         => "array",
  :required     => "required",
  :recipes      => [ 'usermanagement::web_bookmarks' ]

attribute 'web_bookmarks/web_bookmarks/title',
  :display_name => "Title",
  :description  => "Bookmark's title",
  :type         => "string",
  :order        => "0",
  :recipes      => [ 'usermanagement::web_bookmarks' ]

attribute 'web_bookmarks/web_bookmarks/url',
  :display_name => "URL",
  :description  => "Bookmark's URL",
  :type         => "string",
  :validation   => "url",
  :order        => "1",
  :recipes      => [ 'usermanagement::web_bookmarks' ]

attribute 'resource_sharing/resource_sharing',
  :display_name => "Allow resource sharing",
  :description  => "User can share local resources",
  :type         => "string",
  :choice       => [ "true", "false" ],
  :default      => "false",
  :required     => "required",
  :recipes      => [ 'usermanagement::resource_sharing' ]

