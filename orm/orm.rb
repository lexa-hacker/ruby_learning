require 'PG'

class Orm

  def initialize(db_name, db_usr, db_pass)
    @connect = PG.connect( dbname: db_name, user: db_usr, password: db_pass) 
  end

  attr_reader :connect

  def create(table_name, data)
    make_dml("INSERT INTO #{table_name} (#{data.keys.join(",")}) values (#{data.values.collect{|x| x.class==String ? "'"+x+"'" : x}.join(",")});").cmd_tuples.to_s + " records were created"
  end

  def update(table_name, data, cond)
    make_dml("UPDATE #{table_name} SET #{make_attr_str(data)} WHERE #{make_attr_str(cond)};").cmd_tuples.to_s + " records were changed"
  end

  def delete(table_name, cond)
    make_dml("DELETE FROM #{table_name} WHERE #{make_attr_str(cond)};").cmd_tuples.to_s + " records were deleted"
  end

  def find(table_name, cond)
    if cond.empty?
      result = make_dml("SELECT * FROM #{table_name};")
    else
      result = make_dml("SELECT * FROM #{table_name} WHERE #{make_attr_str(cond)};")
    end
    if result.ntuples > 0
      arr = []
      result.each {|row| arr.push(row)}
      return arr
    end
    result.ntuples.to_s + " records were selected"
  end

  private
    def make_dml(execution_string)
      @connect.exec(execution_string)
    end

    def make_attr_str(hash)
      hash.to_a.collect{|x| [x[0],x[1].class==String ? "'"+x[1]+"'" : x[1]].join("=")}.join(" and ")
    end
end