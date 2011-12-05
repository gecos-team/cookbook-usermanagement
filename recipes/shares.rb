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

# A general bookmark to see the remote resources from non-gvfs apps
remote_resources = "file:///home/#{node.user}/.gvfs/ Unidades de red"

# We make sure the general bookmark is always there
conf_plain_file "/home/#{node.user}/.gtk-bookmarks" do
  pattern remote_resources
  new_line remote_resources
  owner node.user
  group node.user
  action :add
end

# Now the remote resources passed as attributes
node.shares.each do |share|
  bookmark = name_for_uri(share[:uri])

  conf_plain_file "/home/#{node.user}/.gtk-bookmarks" do
    pattern share[:uri]
    new_line "#{share[:uri]} #{bookmark}"
    owner node.user
    group node.user
    action share[:action].to_sym if %w{ add remove }.include? share[:action]
  end
end
