require_relative '../orm/orm'
require_relative 'weather'
require_relative 'currencies'

class Interactive

  def initialize
    @db = Orm.new('testdb','testusr','postgre')
  end

  def interactive
    puts "Use the following commands: weather, currencies, exit."
    command = gets.chomp
    case command
    when "weather"
      wez = Weather.new
      wez.show
      wez.save_to_db(@db)
    when "currencies"
      cur = Currencies.new
      cur.show
      cur.save_to_db(@db)
    when "exit"
      dump = File.open("dump.txt", "w")
      unless cur.nil?
        cur.select_from_db(@db).each do |element|
          dump.puts element.values.join("  ")
        end
      end
      unless wez.nil?
        wez.select_from_db(@db).each do |element|
          dump.puts element.values.join("  ")
        end
      end
      return
    else
      puts "vse hernya, davai po novoi"
    end
    interactive
  end
end