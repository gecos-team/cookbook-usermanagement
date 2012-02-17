#
# Cookbook Name:: usermanagement
# Recipe:: external_units
#
# Copyright 2011 Junta de Andalucía
#
# Authors::
#  * David Amian <damian@emergya.com>
#  * Juanje Ojeda <jojeda@emergya.com>
# 
# Based on the David Amian's polkit recipe
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

udisk_policy = "/usr/share/polkit-1/actions/org.freedesktop.udisks.policy"
cookbook_file udisk_policy do
  source "udisks.policy"
  owner "root"
  group "root"
  mode "0644"
end

granted_users = Array.new

node['userdata'].each do |userdata|

  # Can this user mount devices?
  next if userdata["external_units"]["mount"] == 'false'
  granted_users << userdata["name"]
end
users = granted_users.uniq.inject("") do |users,user|
  users << ";unix-user:#{user}"
end

desktop_pkla = "/var/lib/polkit-1/localauthority/10-vendor.d/com.ubuntu.desktop.pkla"
template desktop_pkla do
  source "com.ubuntu.desktop.pkla.erb"
  owner "root"
  group "root"
  mode "0644"
  variables :user_mount => users
end

