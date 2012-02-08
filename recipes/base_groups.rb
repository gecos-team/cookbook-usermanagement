#
# Cookbook Name:: usermanagement
# Recipe:: base_groups
#
# Copyright 2011 Junta de Andalucía
#
# Authors::
#  * David Amian Valle <damian@emergya.com>
#  * Roberto C. Morano <rcmorano@emergya.com>
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
require 'etc'

base_groups = node[:group_management][:base_groups]

users_to_add = []
users.each do |userdata|
  users_to_add << userdata["name"]
end

base_groups.each do |grp|
  grp_members = Etc.getgrnam(grp).mem

  grp_members = grp_members + users_to_add
  unless grp_members.empty?
    grp_members = grp_members
    grp_members.uniq!

    group grp do
      action :manage
      members grp_members
      append false
    end
  end
end
