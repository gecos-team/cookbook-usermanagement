Description
===========

This cookbook is ment to manage the user configurations of a node. It has
different sort of resources and recipes to manage them.

The cookbook install resources and providers to manage configuration files.

You can add the recipe `conf` to a node _runlist_, so all the recipes from
that runlist can use the resources and providers.

Recipes
=======

The current recipes right now are:


Shares
------

This cookbok install a policy of shares (network shared directories)
to a specific user of a node.

The cookbook add to (or remove from) the $HOME/.gtk-bookmarks bookmarks
to be mounted remotely by the node.

This will work just for GNOME desktops, so OS where you can run GNOME.

Attributes
----------

* `node['shares']['user']` - Name of the user to apply the policies
* `node['shares']['shares']` - List of shares and actions. Actions can be :add or :remove

Example:

```
default['shares'][:user] = "juan"
default['shares'][:shares] = [
                              {:uri => 'smb://machine_one/path/to/the/directory', :action => "add"},
                              {:uri => 'smb://remote_host_B/path/Shared',         :action => "add"},
                              {:uri => 'nfs://server_nfs/isos/',                  :action => "remove"}
                             ]
```


License and Author
==================

Authors::
 * Roberto C. Morano (<rcmorano@emergya.com>)
 * David Amián (<damian@emergya.com>)
 * Juanje Ojeda (<jojeda@emergya.com>)

Copyright 2011 Junta de Andalucía

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

