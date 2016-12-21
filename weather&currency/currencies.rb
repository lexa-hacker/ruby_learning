require_relative 'commonMethods'

class Currencies < Common
  def initialize
    @parameters = get_currencies
    @table_name = "currencies"
    @table_fields = ["currency", "exchange", "on_date"]
  end
  
  attr_reader :parameters

  private
    def get_currencies
      currencies = Mechanize.new
      currencies.get('http://www.alpari.ru/ru/analytics/currency/') do |page|
        cur_list = []
        page.search('.currency__informer').each do |element|
          name = "Валюта: " + element.search('.currency__informer-header').text
          value = "Стоимость: " + element.search('.currency__informer-value-main').text
          date = "На дату: " + element.search('.currency__informer-value-date').text
          cur_list.push([name, value, date])
        end
        return cur_list
      end
    end
end