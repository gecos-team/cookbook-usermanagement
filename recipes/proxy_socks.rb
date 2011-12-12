#
# Cookbook Name:: usermanagement
# Recipe:: proxy_socks
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

users.each do |userdata|

  username = userdata["id"]
  mode = userdata["proxy_socks"]["mode"]

  usermanagement_desktopsetting "mode" do
    type "string"
    value mode
    schema "org.gnome.system.proxy"
    username username
    provider "usermanagement_gsettings"
    action :set
  end

  %w{ host port }.each do |key|
    usermanagement_desktopsetting key do
      type "string"
      value userdata["proxy_socks"][key]
      schema "org.gnome.system.proxy.socks"
      username username
      provider "usermanagement_gsettings"
      action :set
    end
  end

end

