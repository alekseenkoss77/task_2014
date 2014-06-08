class AddPgFulltextSearchIndexes < ActiveRecord::Migration
  def change
  	execute "CREATE INDEX pg_meetings_name_index ON meetings USING gin(to_tsvector('english', name));
  			 CREATE INDEX pg_users_name_index ON users USING gin(to_tsvector('english', name))"
  end
end
