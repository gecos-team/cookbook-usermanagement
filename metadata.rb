name              "usermanagement"
version           "0.1.1"
maintainer        "rcmorano"
maintainer_email  "rcmorano@emergya..com"
license           "Apache 2.0"
description       "This cookbook provides the ability to change user specific configurations"
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))

provides          "usermanagement::background"
provides          "usermanagement::shares"

recipe            "usermanagement::background", "Set user specific desktop background"
recipe            "usermanagement::shares", "Set the remote resource to be mounted"

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

