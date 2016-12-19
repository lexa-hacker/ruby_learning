module Db_exec
	
	def insert_to_db (db, tbl, hash)
		db.create(tbl, hash)
	end

	def select_from_db (db, tbl, hash)
		db.find(tbl, hash)
	end

end