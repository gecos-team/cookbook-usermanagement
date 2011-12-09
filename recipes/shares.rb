#
# Cookbook Name:: shares
# Recipe:: default
#
# Copyright 2011, Junta de Andalucía
#
# GPL v2
#

def name_for_uri(uri)
  # NOTE: We can't use the library URI because it hasn't implemented
  # the smb protocol
  host = uri.match('(smb|nfs|ftp):\/\/([a-zA-Z]+\w*)\/.*')[2]
  directory = ::File.basename uri
  "#{host}:#{directory}"
end

users.each do |userdata|

  username = userdata["id"]

  # A general bookmark to see the remote resources from non-gvfs apps
  remote_resources = "file:///home/#{username}/.gvfs/ Unidades de red"

  # We make sure the general bookmark is always there
  usermanagement_plain_file "/home/#{username}/.gtk-bookmarks" do
    pattern remote_resources
    new_line remote_resources
    owner username
    group username
    action :add
  end

  # Now the remote resources passed as attributes
  userdata["shares"].each do |share|
    bookmark = name_for_uri(share[:uri])

    usermanagement_plain_file "/home/#{username}/.gtk-bookmarks" do
      pattern share[:uri]
      new_line "#{share[:uri]} #{bookmark}"
      owner username
      group username
      action share[:action].to_sym if %w{ add remove }.include? share[:action]
    end
  end

end
