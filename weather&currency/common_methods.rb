require 'mechanize'
require_relative 'orm'

class CommonMethods < Orm

  def select_from_db
    self.class.find({})
  end

  def show
    @parameters.each do |element|
      puts element
      puts "\n"
    end
  end

  def save_to_db
    @parameters.each do |element|
      hash = {}
      @table_fields.each do |key|
        hash[key] = element[@table_fields.index(key)]
      end
      self.class.create(hash)
    end
  end

end