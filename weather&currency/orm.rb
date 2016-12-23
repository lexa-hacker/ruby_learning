require 'PG'

class Orm

  @@connect = PG.connect( dbname: "testdb", user: "testusr", password: "postgre") 

  def self.create(data)
    make_dml("INSERT INTO #{self.to_s.downcase} (#{data.keys.join(",")}) values (#{data.values.collect{|x| x.class==String ? "'"+x+"'" : x}.join(",")});").cmd_tuples.to_s + " records were created"
  end

  def self.update(data, conditions)
    make_dml("UPDATE #{self.to_s.downcase} SET #{make_conditions_string(data)} WHERE #{make_conditions_string(conditions)};").cmd_tuples.to_s + " records were changed"
  end

  def self.delete(conditions)
    make_dml("DELETE FROM #{self.to_s.downcase} WHERE #{make_conditions_string(conditions)};").cmd_tuples.to_s + " records were deleted"
  end

  def self.find(conditions)
    if conditions.empty?
      result = make_dml("SELECT * FROM #{self.to_s.downcase};")
    else
      result = make_dml("SELECT * FROM #{self.to_s.downcase} WHERE #{make_conditions_string(conditions)};")
    end
    if result.ntuples > 0
      arr = []
      result.each {|row| arr.push(row)}
      return arr
    end
    result.ntuples.to_s + " records were selected"
  end

  def self.make_dml(execution_string)
    @@connect.exec(execution_string)
  end

  def self.make_conditions_string(hash)
    hash.to_a.collect{|x| [x[0],x[1].class==String ? "'"+x[1]+"'" : x[1]].join("=")}.join(" and ")
  end
end