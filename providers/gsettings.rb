require 'etc'
def initiailize(*args)
  super
  @action = :set
  package 'xvfb' do
    action :nothing
  end.run_action(:install)

  dconf_cache_dir = "/home/#{new_resource.username}/.cache/dconf"
  unless Kernel::test('d', dconf_cache_dir)
    FileUtils.mkdir dconf_cache_dir
    gid = Etc.getpwnam(new_resource.username).gid
    FileUtils.chown_R(new_resource.username, gid, dconf_cache_dir)  
  end
end

action :set do
  execute "set key" do
    command "xvfb-run -w 0 sudo -iu #{new_resource.username} gsettings set #{new_resource.schema} #{new_resource.name} #{new_resource.value}"
  end
end

action :unset do
  execute "unset key" do
    command "xvfb-run -w 0 sudo -iu #{new_resource.username} gsettings reset #{new_resource.schema} #{new_resource.name}"
  end
end
