grape-postgres(Jruby)
=========================

1: Postgresql

	$ createdb notes
	$ psql notes

	## in psql console

	$ notes=# create user notes with password 'notes';
	$ notes=# grant all privileges on database notes to notes;
	$ notes=# \q

2: Create table

	$ rake db:migrate

3: Rubygems

	$ bundle install

5: Start server

	$ ruby server.rb -vs
	
6: API

	$ open http://localhost:9000

	$ curl -X POST -d 'name=qiuhaifeng&body=leavemessage&app=liuyaozhuanggua&ip=123.33.44.55&email=eiffelqiu@qq.com' http://localhost:9000/api/v1/messages/create 

	$ open http://localhost:9000/api/v1/messages/

