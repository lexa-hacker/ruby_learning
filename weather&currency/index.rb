require_relative '../orm/orm'
require_relative 'interactive'

include Interactive

db = Orm.new('testdb','testusr','postgre')

interactive(db)