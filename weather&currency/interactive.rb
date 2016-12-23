require_relative 'weather'
require_relative 'currency'

class Interactive

  def interactive
    puts "Use the following commands: weather, currency, exit."
    command = gets.chomp
    if command == "weather"
      weather = Weather.new
      command_execution weather
    elsif command == "currency"
      currency = Currency.new
      command_execution currency
    elsif command == "exit"
      dump = File.open("dump.txt", "w")
      unless currency.nil?
        currency.save_to_file(dump)
      end
      unless weather.nil?
        weather.save_to_file(dump)
      end
      return
    else
      puts "Wrong command, try again!"
    end
    interactive
  end

  def command_execution obj
    obj.show
    obj.save_to_db
  end

end

Interactive.new.interactive