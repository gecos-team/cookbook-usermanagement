maintainer        "rcmorano"
maintainer_email  "rcmorano@emergya..com"
license           "Apache 2.0"
description       "This cookbook provides the ability to change user specific configurations"
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           "0.0.1"
recipe            "change-background", "set user specific desktop background"

%w{ ubuntu debian }.each do |os|
  supports os
end
