action :set do
  execute "set key" do
    command "xvfb-run sudo -iu #{new_resource.username} gsettings set #{new_resource.schema} #{new_resource.name} #{new_resource.value}"
  end
end

action :unset do
  execute "unset key" do
    command "xvfb-run sudo -iu #{new_resource.username} gsettings reset #{new_resource.schema} #{new_resource.name}"
  end
end
