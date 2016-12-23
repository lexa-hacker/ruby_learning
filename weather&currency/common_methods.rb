require 'mechanize'
require_relative 'orm'

class CommonMethods < Orm

  def show
    @parameters.each do |element|
      puts element
      puts "\n"
    end
  end

  def save_to_db
    @parameters.each do |element|
      data = {}
      @table_fields.each do |key|
        data[key] = element[@table_fields.index(key)]
      end
      self.class.create(data)
    end
  end

  def save_to_file file
    self.class.find({}).each do |element|
      file.puts element.values.join("  ")
    end
  end

end