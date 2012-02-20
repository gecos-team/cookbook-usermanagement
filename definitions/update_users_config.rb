#
# Cookbook Name:: usermanagement
#
# Copyright 2011 Junta de Andalucía
#
# Author::
#  * Juanje Ojeda <jojeda@emergya.com>
#  * Roberto C. Morano <rcmorano@emergya.com>
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


define :update_users_config do
    node['users_def_timestamp'] = 0 unless !node['users_def_timestamp'].nil?
    # unless the definition was run in other chef run do not reprocess it
    if !node['users_def_timestamp'].nil? and ( Time.now.to_i - node['users_def_timestamp'] ) > 3600
      node['userdata'] = []
      node['users'].collect do |user|
        begin
          username = user['username']
          md5name = Digest::MD5.hexdigest(username)
          userdata = data_bag_item('users', md5name)
          userdata["name"] = username
        rescue
          begin
            userdata = data_bag_item('users', "user_skel")
            userdata["id"] = 'user_skel'
            userdata["name"] = user['username']
          rescue
            next
          end
        end
        userdata['home'] = user['home']
        node['userdata'] << userdata
      end.compact
      
      node['users_def_timestamp'] = Time.now.to_i
   end
end
