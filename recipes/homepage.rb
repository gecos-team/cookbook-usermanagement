#
# Cookbook Name:: usermanagement
# Recipe:: homepage
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
