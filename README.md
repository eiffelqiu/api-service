Api service built with grape, goliath, postgres, rspec
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

	$ ruby server.rb -vs -e production
	
6: API

	$ curl -X POST -d 'name=eiffel&body=leavemessage&app=app1&email=eiffelqiu@qq.com' http://localhost:9000/api/v1/msgs/create

	$ open http://localhost:9000/api/v1/msgs

