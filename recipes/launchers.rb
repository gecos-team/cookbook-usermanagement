#
# Cookbook Name:: usermanagement
# Recipe:: launchers
#
# Copyright 2011 Junta de Andalucía
#
# Author::
#  * David Amian <damian@emergya.com>
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

node['userdata'].each do |userdata|
  username = userdata["name"]
  homedir = userdata["home"]

  desktop_path = "/usr/share/applications/"
  launchers_path = homedir+"/Escritorio/"

  unless Kernel::test('d', launchers_path)
    FileUtils.mkdir_p(launchers_path)
    gid = Etc.getpwnam(new_resource.username).gid
    FileUtils.chown_R(username, gid, launchers_path)
  end


  userdata["launchers"]["launchers"].each do |desktopfile|
    if FileTest.exist? desktop_path + desktopfile["name"] and not desktopfile["name"].empty? and not desktopfile["name"].nil?
      FileUtils.cp desktop_path + desktopfile["name"],  launchers_path
      FileUtils.chown username, username, launchers_path + desktopfile["name"]
      FileUtils.chmod 0775, launchers_path + desktopfile["name"]
    end
  end

end
