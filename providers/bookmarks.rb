begin
 require 'sqlite3'
rescue LoadError => e
 Chef::Log.warn("Dependency 'sqlite3' not loaded: #{e}")
end

action :add do
  if FileTest.exist? new_resource.sqlitedb
    begin
      db = SQLite3::Database.open(new_resource.sqlitedb)
      date_now = Time.now.to_i*1000000
      url = db.get_first_value("SELECT url FROM moz_places WHERE url LIKE \'#{new_resource.bookmark_url}\'")
      if url.nil?
        id_toolbar_bookmarks = db.get_first_value("SELECT id FROM moz_bookmarks WHERE title=\'Barra de herramientas de marcadores\'")
        last_pos_toolbar = db.get_first_value("SELECT MAX(position) FROM moz_bookmarks WHERE parent=#{id_toolbar_bookmarks}")
        id_folder_bookmarks = db.get_first_value("SELECT id FROM moz_bookmarks WHERE title=\'Marcadores corporativos\'")
        last_pos_folder = 0
        if id_folder_bookmarks.nil?
          db.execute("INSERT INTO moz_bookmarks
                      (type,parent,position,title,dateAdded,lastModified)
                      VALUES
                      (2,#{id_toolbar_bookmarks},#{last_pos_toolbar+1},\'Marcadores corporativos\',#{date_now},#{date_now})")
          id_folder_bookmarks = db.get_first_value("SELECT last_insert_rowid()")
        else
          last_pos_folder = db.get_first_value("SELECT MAX(position) FROM moz_bookmarks WHERE parent=#{id_folder_bookmarks}")
        end
        db.execute("INSERT INTO moz_places
                    (url,title,rev_host,visit_count,hidden,typed,last_visit_date)
                    VALUES
                    (\'#{new_resource.bookmark_url}\',\'#{new_resource.bookmark_title}\',\'#{new_resource.bookmark_url.reverse}.\',1,0,1,#{date_now})")
        foreign_key = db.get_first_value("SELECT last_insert_rowid()")
        db.execute("INSERT INTO moz_bookmarks
                    (type,fk,parent,position,title,dateAdded,lastModified)
                    VALUES
                    (1,#{foreign_key},#{id_folder_bookmarks},#{last_pos_folder+1},\'#{new_resource.bookmark_title}\',#{date_now},#{date_now})")
      end
    rescue
      Chef::Log.debug("Cannot add the bookmark. Firefox should not be running")
    end
  else
    Chef::Log.debug("Cannot add the bookmark. The database doesn't exist")
  end
end
