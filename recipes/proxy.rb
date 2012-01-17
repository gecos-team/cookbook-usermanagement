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

package 'xvfb' do
  action :nothing
end.run_action(:install)

users.each do |userdata|

  username = userdata["id"]
  mode = userdata["proxy"]["mode"]
  if mode == "socks"
    usermanagement_desktopsetting "mode" do
      type "string"
      value "manual"
      schema "org.gnome.system.proxy"
      username username
      provider "usermanagement_gsettings"
      action :set
    end

    %w{ host port }.each do |key|
      usermanagement_desktopsetting key do
        type "string"
        value userdata["proxy"][key]
        schema "org.gnome.system.proxy.socks"
        username username
        provider "usermanagement_gsettings"
        action :set
      end
    end

    %w{ host port }.each do |key|
      if key=="host"
        desktop_value="\\\'\\\'"
        desktop_type="string"
      else
        desktop_type="integer"
        desktop_value="0"
      end
      usermanagement_desktopsetting key do
        type desktop_type
        value desktop_value
        schema "org.gnome.system.proxy.http"
        username username
        provider "usermanagement_gsettings"
        action :set
      end
    end
    
    usermanagement_desktopsetting 'enabled' do
      type "string"
      value "false"
      schema "org.gnome.system.proxy.http"
      username username
      provider "usermanagement_gsettings"
      action :set
    end

    
  elsif mode == "http"
    usermanagement_desktopsetting "mode" do
      type "string"
      value "manual"
      schema "org.gnome.system.proxy"
      username username
      provider "usermanagement_gsettings"
      action :set
    end

    %w{ host port }.each do |key|
      usermanagement_desktopsetting key do
        type "string"
        value userdata["proxy"][key]
        schema "org.gnome.system.proxy.socks"
        username username
        provider "usermanagement_gsettings"
        action :set
      end
    end

    usermanagement_desktopsetting 'enabled' do
      type "string"
      value "true"
      schema "org.gnome.system.proxy.http"
      username username
      provider "usermanagement_gsettings"
      action :set
    end

    %w{ host port }.each do |key|
      if key=="host"
        desktop_value="\\\'\\\'"
        desktop_type="string"
      else
        desktop_value="0"
        desktop_type="integer"
      end
      usermanagement_desktopsetting key do
        type desktop_type
        value desktop_value
        schema "org.gnome.system.proxy.socks"
        username username
        provider "usermanagement_gsettings"
        action :set
      end
    end

  else
    usermanagement_desktopsetting "mode" do
      type "string"
      value "none"
      schema "org.gnome.system.proxy"
      username username
      provider "usermanagement_gsettings"
      action :set
    end
  end


end

