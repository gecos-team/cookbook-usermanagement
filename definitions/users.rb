#
# Cookbook Name:: usermanagement
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
require 'etc'

define :users do

  Dir["/home/*"].each do |homedir|
    Etc.passwd do |entry|
      next unless entry.dir =~ /^\/home/
      next unless entry.dir == homedir
      begin
        user = data_bag_item('users', entry.name)
      rescue
        next
      end
      user
    end
  end

end
