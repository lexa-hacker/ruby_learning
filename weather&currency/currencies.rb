require 'mechanize'
require_relative 'show'
require_relative 'db_exec'

class Currencies
  def initialize
    @parameters = get_currencies
  end
  
  attr_reader :parameters

  include Show
  include Db_exec

  def show
    @parameters.each do |element|
      show_elt element
    end
  end

  def save_to_db(db)
    @parameters.each do |element|
      insert_to_db(db, "currencies", {"currency"=>element[0], "exchange"=>element[1], "on_date"=>element[2]})
    end
  end

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