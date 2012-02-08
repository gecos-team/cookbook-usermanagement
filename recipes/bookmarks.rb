#
# Cookbook Name:: usermanagement
# Recipe:: bookmarks
#
# Copyright 2011 Junta de Andalucía
#
# Authors::
#  * David Amian <damian@emergya.com>
#  * Juanje Ojeda <jojeda@emergya.com>
#
# Based on the David Amian's bookmarks recipe
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

package 'libsqlite3-ruby' do
  action :nothing
end.run_action(:install)
Gem.clear_paths
require 'sqlite3'

users.each do |userdata|
  username = userdata["name"]
  homedir = userdata["home"]
  sqlitefiles = []
  profiles = "#{homedir}/.mozilla/firefox/profiles.ini"
  if File.exist? profiles
    File.open(profiles, "r") do |infile|
      while (line = infile.gets)
        aline=line.split('=')
        if aline[0] == 'Path'
          sqlitefiles << "#{homedir}/.mozilla/firefox/#{aline[1]}/places.sqlite"
        end
      end
    end
 
    sqlitefiles.each do |sqlitefile|
      userdata["bookmarks"]["bookmarks"].each do |bookmark|
        unless bookmark["title"].empty? or bookmark["url"].empty?
          usermanagement_bookmarks sqlitefile do
            sqlitedb sqlitefile
            bookmark_title bookmark["title"]
            bookmark_url bookmark["url"]
            action :add
          end
        end
      end
    end
  end
end

