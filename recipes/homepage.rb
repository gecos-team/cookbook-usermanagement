#
# Cookbook Name:: usermanagement
# Recipe:: homepage
#
# Copyright 2011 Junta de Andalucía
#
# Authors::
#  * David Amian <damian@emergya.com>
#  * Juanje Ojeda <jojeda@emergya.com>
#
# Based on the David Amian's homepage recipe
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

default_prefs = "/usr/share/firefox-firma/defaults/profile/prefs.js"

template default_prefs do
  source "firefox-prefs.js.erb"
  owner "root"
  group "root"
  mode "0644"
  variables :homepage => node.homepage
end

users.each do |userdata|
  username = userdata["id"]
  homepage = userdata["homepage"]["homepage"]

  user_prefs = "/home/#{username}/.mozilla/firefox/firefox-firma/prefs.js"

  usermanagement_plain_file user_prefs do
    pattern    /user_pref\(\s*\"browser.startup.homepage\".*/
    new_line   "user_pref(\"browser.startup.homepage\", \"#{homepage}\");"
  end

end
