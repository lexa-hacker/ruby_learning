#create table usrs (login varchar(20), password varchar(20));
#insert into usrs (login, password) values('user1', 'pass1');
#insert into usrs (login, password) values('user2', 'pass2');
#insert into usrs (login, password) values('user3', 'pass3');
require_relative 'orm'
require_relative 'user'

tst_db = ORM.new('testdb','testusr','postgre')

#create/find
p tst_db.create('usrs', {'login'=>'tst_usr', 'password'=>'tst_pwd'})
p tst_db.find('usrs', {'login'=>'tst_usr'})
#update/find
p tst_db.update('usrs', {'password'=>'tst_pwd'}, {'login'=>'tst_usr'})
p tst_db.find('usrs', {'login'=>'tst_usr'})
#delete/find
p tst_db.delete('usrs', {'login'=>'tst_usr'})
p tst_db.find('usrs', {'login'=>'tst_usr'})
