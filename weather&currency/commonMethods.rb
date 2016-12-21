require 'mechanize'

class Common

  def select_from_db (db)
    db.find(@table_name, {})
  end

  def show
    @parameters.each do |element|
      puts element
      puts "\n"    end
  end

  def save_to_db(db)
    @parameters.each do |element|
      hash = {}
      @table_fields.each do |key|
        hash[key] = element[@table_fields.index(key)]
      end
      db.create(@table_name, hash)
    end
  end

end