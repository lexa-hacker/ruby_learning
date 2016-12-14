require 'PG'

class ORM

  def initialize(db_name, db_usr, db_pass)
    @connect = PG.connect( :dbname=>db_name, :user=>db_usr, :password=>db_pass) 
  end

  attr_reader :connect

  def create(tbl, data)
    make_DML("INSERT INTO #{tbl} (#{data.keys.join(",")}) values (#{data.values.collect{|x| x.class==String ? "'"+x+"'" : x}.join(",")});").cmd_tuples.to_s + " records were created"
  end

  def update(tbl, data, cond)
    make_DML("UPDATE #{tbl} SET #{make_attr_str(data)} WHERE #{make_attr_str(cond)};").cmd_tuples.to_s + " records were changed"
  end

  def delete(tbl, cond)
    make_DML("DELETE FROM #{tbl} WHERE #{make_attr_str(cond)};").cmd_tuples.to_s + " records were deleted"
  end

  def find(tbl, cond)
    result = make_DML("SELECT * FROM #{tbl} WHERE #{make_attr_str(cond)};")
    if result.ntuples > 0
      arr = []
      result.each {|row| arr.push(row)}
      return arr
    end
    result.ntuples.to_s + " records were selected"
  end

  private
    def make_DML(execution_string)
      @connect.exec(execution_string)
    end

    def make_attr_str(hash)
      hash.to_a.collect{|x| [x[0],x[1].class==String ? "'"+x[1]+"'" : x[1]].join("=")}.join(" and ")
    end
end