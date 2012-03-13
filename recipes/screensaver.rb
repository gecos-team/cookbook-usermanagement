#
# Cookbook Name:: usermanagement
# Recipe:: screensaver
#
# Copyright 2011 Junta de Andalucía
#
# Author::
#  * Juanje Ojeda <jojeda@emergya.com>
#
# Based on the Roberto C. Morano's applyuserconfs recipe
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

update_users_config

node['userdata'].each do |userdata|

  username = userdata["name"]
  darken = userdata["screensaver"]["darken"]
  time_idle = userdata["screensaver"]["time_idle"]
  lock = userdata["screensaver"]["lock"]
  time_lock = userdata["screensaver"]["time_lock"]
  
  usermanagement_desktopsetting "idle-activation-enabled" do
    type "string"
    value darken
    schema "org.gnome.desktop.screensaver"
    username username
    provider "usermanagement_gsettings"
    action :set
  end 
    
  usermanagement_desktopsetting "lock-enabled" do
    type "string"
    value lock
    schema "org.gnome.desktop.screensaver"
    username username
    provider "usermanagement_gsettings"
    action :set
  end 
    
  
  usermanagement_desktopsetting "idle-delay" do
    type "string"
    value time_idle
    schema "org.gnome.desktop.session"
    username username
    provider "usermanagement_gsettings"
    action :set
  end 
    

  usermanagement_desktopsetting "lock-delay" do
    type "string"
    value time_lock
    schema "org.gnome.desktop.screensaver"
    username username
    provider "usermanagement_gsettings"
    action :set
  end 

end

