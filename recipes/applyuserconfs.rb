#
# Cookbook Name:: user-management
# Recipe:: applyuserconfs
#
# Copyright 2011 rcmorano
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

user = data_bag_item('usuarios', 'rcmorano')

for hash in user['mostrar iconos en el escritorio'].keys do
    regexpres = /(.*)\.(.*$)/.match(hash)
    schemastr = regexpres[1]
    key = regexpres[2]
    usermanagement_desktopsetting key do
        type "string"
        name key
        value user['mostrar iconos en el escritorio'][hash]
        schema schemastr
        username "rcmorano"
        action :set
            provider "usermanagement_gsettings"
    end     
end


#gsettings_path = user['mostrar iconos en el escritorio'].keys.first


#puts gsettings_path
#puts gsettings_value

#for user in node.home_users do
#
#    username = user[1]['username']
#    usercfg = nil

#    begin
#        usercfg = data_bag_item('usuarios', username)
#    rescue
#        break
#    end

    #if usercfg != nil
    #    for cfg in usercfg do
    #        puts cfg
    #    end
        # show desktop icons or not
#        usermanagement_desktopsetting "/desktop/gnome/background/picture_filename" do
#            type "string"
#            action :set
#        end   
    #end
#end
