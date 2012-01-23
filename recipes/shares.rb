#
# Cookbook Name:: usermanagement
# Recipe:: shares
#
# Copyright 2011 Junta de Andalucía
#
# Author::
#  * Juanje Ojeda <jojeda@emergya.com>
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

def name_for_uri(uri)
  # NOTE: We can't use the library URI because it hasn't implemented
  # the smb protocol
  host = uri.match('(smb|nfs|ftp):\/\/([\S]*)\/.*')[2]
  directory = ::File.basename uri
  "#{host}:#{directory}"
end

users.each do |userdata|
  username = userdata["name"]
  homedir = userdata["home"]

  # A general bookmark to see the remote resources from non-gvfs apps
  remote_resources = "file://#{homedir}/.gvfs/ Unidades de red"

  # We make sure the general bookmark is always there
  usermanagement_plain_file "#{homedir}/.gtk-bookmarks" do
    pattern remote_resources
    new_line remote_resources
    owner username
    group username
    action :add
  end

  # Now the remote resources passed as attributes
  shares=userdata["shares"]["shares"].map{|x| x[1]}.flatten
  shares.each do |share|
    bookmark = name_for_uri(share["uri"])

    usermanagement_plain_file "#{homedir}/.gtk-bookmarks" do
      pattern share["uri"]
      new_line "#{share["uri"]} #{bookmark}"
      owner username
      group username
      action share["action"].to_sym if %w{ add remove }.include? share["action"]
    end
  end

end
