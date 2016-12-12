require 'PG'

class ORM

  def initialize(db_name, db_usr, db_pass)
    @connect = PG.connect( :dbname=>db_name, :user=>db_usr, :password=>db_pass) 
  end

  attr_reader :connect

  def create(tbl, data)
    i=0
    fields = ""
    values = ""
    data.each do |key, value|
      i += 1
      fields += key
      if value.class == String
        values += "'" + value + "'"
      else
        values += value.to_s
      end
      if i < data.length
        fields += "," 
        values += ","
      end
    end
    makeDML("INSERT INTO #{tbl} (#{fields}) values (#{values});").cmd_tuples.to_s + " records were created"
  end

  def update(tbl, data, cond)
    updateble = make_attr_str(data)
    conditions = make_attr_str(cond)
    makeDML("UPDATE #{tbl} SET #{updateble} WHERE #{conditions};").cmd_tuples.to_s + " records were changed"
  end

  def delete(tbl, cond)
    conditions = make_attr_str(cond)
    makeDML("DELETE FROM #{tbl} WHERE #{conditions};").cmd_tuples.to_s + " records were deleted"
  end

  def find(tbl, cond)
    conditions = make_attr_str(cond)
    result = makeDML("SELECT * FROM #{tbl} WHERE #{conditions};")
    if result.ntuples > 0
      result.each do |row|
        return row
      end
    end
    result.ntuples.to_s + " records were selected"
  end

  private
    def makeDML(executionString)
      @connect.exec(executionString)
    end

    def make_attr_str(hash)
      i = 0
      result = ""
      hash.each do |key, value|
        i += 1
        result += key + "="
        if value.class == String
          result += "'" + value + "'"
        else
          result += value.to_s
        end
        if i < hash.length
          result += " and "
        end
      end
      result
    end
end