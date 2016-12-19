#create table usrs (login varchar(20), password varchar(20));

require_relative 'orm'

tst_db = Orm.new('testdb','testusr','postgre')#db,usr,pwd

#create/find
p tst_db.create('usrs', {'login'=>'tst_usr', 'password'=>'tst_pwd'})
p tst_db.find('usrs', {'login'=>'tst_usr'})
#update/find
p tst_db.update('usrs', {'password'=>'tst_pwd_changed'}, {'login'=>'tst_usr'})
p tst_db.find('usrs', {'login'=>'tst_usr'})
#delete/find
p tst_db.delete('usrs', {'login'=>'tst_usr'})
p tst_db.find('usrs', {'login'=>'tst_usr'})