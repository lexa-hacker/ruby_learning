require 'mechanize'
require_relative 'show'
require_relative 'db_exec'

class Weather
  def initialize
    @parameters = get_weather
  end

  attr_reader :parameters

  include Show
  include Db_exec

  def show
    show_elt @parameters
  end
  
  def save_to_db(db)
    insert_to_db(db, "weather", {"temperature"=>@parameters[0], "wind"=>@parameters[1], "humidity"=>@parameters[2], "pressure"=>@parameters[3], "comment"=>@parameters[4]})
  end

  private
    def get_weather
      weather = Mechanize.new
      weather.get('https://yandex.ru/pogoda/taganrog') do |page|
        temperature = "Температура: " + page.search('.current-weather__thermometer_type_now').text.gsub(" "," ").gsub("−","-")
        comment = page.search('.current-weather__comment').text
        wind, humidity, pressure = ""
        page.search('.current-weather__info-row').each do |elt|
          wind = elt.text if elt.text.include? "Ветер"
          humidity = elt.text if elt.text.include? "Влажность"
          pressure = elt.text if elt.text.include? "Давление"
        end
        return [temperature, wind, humidity, pressure, comment]
      end
    end
end