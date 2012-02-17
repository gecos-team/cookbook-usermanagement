#
# Cookbook Name:: usermanagement
# Recipe:: background
#
# Copyright 2011 Junta de Andalucía
#
# Author::
#  * Juanje Ojeda <jojeda@emergya.com>
# 
# Based on the Alfonso de Cala's background and
# the Roberto C. Morano's applyuserconfs recipes
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
  homedir = userdata["home"]

  local_dir_path = "#{homedir}/.cache/gnome-control-center/backgrounds/"
  # Let's be sure the parent directory exists
  directory local_dir_path do
    owner username
    recursive true
    action :create
  end
  filename = userdata['background']['name']
  file_url = userdata["background"]["file_url"]
  if (!filename == nil or !filename.empty?) and (!file_url == nil or !file_url.empty?)

    local_file_path = ::File.join(local_dir_path, filename)
    remote_file local_file_path do
      source file_url
      owner username
      mode "0644"
    end

    if File.exists?(local_file_path)
      usermanagement_desktopsetting "picture-uri" do
        type "string"
        name "picture-uri"
        value local_file_path
        schema "org.gnome.desktop.background"
        username username
        provider "usermanagement_gsettings"
        action :set
      end
    end
  end
end

