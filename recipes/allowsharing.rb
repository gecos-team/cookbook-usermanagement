#
# Cookbook Name:: usermanagement
# Recipe:: allowsharing
#
# Copyright 2011 Junta de Andalucía
#
# Author::
#  * Antonio Hernández <ahernandez@emergya.com>
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

# Default Samba group
GRP_SAMBA = 'sambashare'

def manage_samba_members(samba_members)

  users_to_add = []
  users_to_remove = []

  users.each do |userdata|
    username = userdata['id']
    if userdata['allowsharing']
      users_to_add << username
    else
      users_to_remove << username
    end
  end

  samba_members = samba_members + users_to_add
  samba_members = samba_members - users_to_remove
  samba_members.uniq!

  group GRP_SAMBA do
    action :manage
    members samba_members
    append false
  end
end

begin
  samba_members = Etc.getgrnam(GRP_SAMBA).mem
  manage_samba_members samba_members
rescue Exception => e
  # Does exists the group sambashare?. Probably
  # Samba isn't installed in the machine...
  puts e.message
end

