require_relative 'weather'
require_relative 'currency'

class Interactive

  def interactive
    puts "Use the following commands: weather, currencies, exit."
    command = gets.chomp
    case command
    when "weather"
      wez = Weather.new
      wez.show
      wez.save_to_db
    when "currencies"
      cur = Currency.new
      cur.show
      cur.save_to_db
    when "exit"
      dump = File.open("dump.txt", "w")
      unless cur.nil?
        cur.select_from_db.each do |element|
          dump.puts element.values.join("  ")
        end
      end
      unless wez.nil?
        wez.select_from_db.each do |element|
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

Interactive.new.interactive