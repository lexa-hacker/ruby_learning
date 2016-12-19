require_relative 'weather'
require_relative 'currencies'

module Interactive
  def interactive(db)
    command = gets.chomp
    case command
    when "weather"
      wez = Weather.new
      wez.show
      wez.save_to_db(db)
    when "currencies"
      cur = Currencies.new
      cur.show
      cur.save_to_db(db)
    when "exit"
      dump = File.open("dump.txt", "w")
      if cur.respond_to?(:select_from_db)
        cur.select_from_db(db, "currencies", {}).each do |element|
          dump.puts element.values.join("  ")
        end
      end
      if wez.respond_to?(:select_from_db)
        wez.select_from_db(db, "weather", {}).each do |element|
          dump.puts element.values.join("  ")
        end
      end
      return
    else
      puts "vse hernya, davai po novoi"
    end
    interactive(db)
  end
end