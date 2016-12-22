require_relative 'common_methods'

class Weather < CommonMethods
  def initialize
    @parameters = get_weather
    @table_fields = ["temperature","wind","humidity","pressure","comment"]
  end

  attr_reader :parameters

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
        return [[temperature, wind, humidity, pressure, comment]]
      end
    end
end