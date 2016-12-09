#create table usrs (login varchar(20), password varchar(20));
#insert into usrs (login, password) values('user1', 'pass1');
#insert into usrs (login, password) values('user2', 'pass2');
#insert into usrs (login, password) values('user3', 'pass3');
require 'PG'

method = ARGV[0] #create/update/delete/find
usr_login = ARGV[1]
usr_pwd = ARGV[2]

def connection
	PG.connect( :dbname=>'testdb', :user=>'testusr', :password=>'postgre') 
end

class User
	def initialize(attributes)
		@login = attributes[:login]
		@password = attributes[:password]
	end

	attr_accessor :login, :password
end

def makeDML(executionString)
	connection.exec(executionString)
end

def createUsr(login, pass)
	usr = User.new({:login=>login, :password=>pass})
	makeDML("INSERT INTO usrs (login, password) values ('#{usr.login}', '#{usr.password}');")
	return usr
end

def updateUsr(login, pass)
	usr = User.new({:login=>login, :password=>pass})
	makeDML("UPDATE usrs SET password='#{usr.password}' WHERE login='#{usr.login}';")
	return usr
end

def deleteUsr(login, pass=nil)
	usr = User.new({:login=>login, :password=>pass})
	makeDML("DELETE FROM usrs WHERE login='#{usr.login}';")
	return usr
end

def findUsr(login, pass=nil)
	makeDML("SELECT * FROM usrs WHERE login='#{login}';").each do |row|
		return User.new({:login=>row["login"].rstrip, :password=>row["password"].rstrip})
 	end
end

user = 	case method
	when "create"
		createUsr(usr_login, usr_pwd)
	when "update"
		updateUsr(usr_login, usr_pwd)
	when "delete"
		deleteUsr(usr_login)
	when "find"
		findUsr(usr_login)
	end

p user