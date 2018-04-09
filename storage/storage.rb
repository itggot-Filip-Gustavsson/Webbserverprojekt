require_relative 'orm.rb'


class App < Sinatra::Base

	enable :sessions

	get '/index' do 
		db = SQLite3::Database.open('db/login.sqlite')
		@user = User.one(session[:user])
		@sharedcontent = []
		@adminpanel = User.all
		@usercontent = Usercontent.all(@user.id)
		#@sharedcontentid = db.execute("SELECT sharedcontentid FROM sharedcontent WHERE sharedto_userid = ?", [@user.id])
		#@sharedby = db.execute("SELECT sharedby FROM sharedcontent  WHERE sharedto_userid = ?", [@user.id])
		@sharedcontent = Sharedcontent.all(@user.id)
		if !session[:user]
			redirect '/login'
		end
		slim :index
	end

	post '/index' do 
		@user = User.one(session[:user])
		content = params['content']
		db = SQLite3::Database.open('db/login.sqlite')
		db.execute("INSERT INTO usercontent(Userid, content) VALUES (?, ?) ", [@user.id, content])

		redirect '/index'
	end	

	post '/remove' do
		contentid = params['remove']
		db = SQLite3::Database.open('db/login.sqlite')
		db.execute("DELETE FROM usercontent WHERE contentid = ?", [contentid])
		db.execute("DELETE FROM sharedcontent WHERE sharedcontentid = ?", [contentid])
		redirect '/index'
	end

	post '/removeuser' do
		userid = params['remove']
		@user = User.one(userid)
		db = SQLite3::Database.open('db/login.sqlite')
		db.execute("DELETE FROM users WHERE id = ?", [@user.id])
		db.execute("DELETE FROM usercontent WHERE Userid = ?", [@user.id])
		db.execute("DELETE FROM sharedcontent WHERE sharedby = ?", [@user.username])
		redirect '/index'
	end

	post '/share' do 
		contentid = params['share']
		user = params['users']
		sharedby = params['sharedby']

		db = SQLite3::Database.open('db/login.sqlite')
		userid = db.execute("SELECT id FROM users WHERE Username = ?", [user])

		db.execute("INSERT INTO sharedcontent (sharedcontentid, sharedto_userid, sharedby) VALUES (?, ?, ?) ", [contentid, userid, sharedby])

		redirect '/index'
	end

	get '/login' do 
		
		@fail = session[:login_fail]
		slim :login
	end

	get '/register' do 
		@rpass = session[:pwr]
		slim :register
	end

	post '/register' do 
		username = params['username']
		password = params['password']
		rpassword = params['rpassword']

		@rpass = true

		if password != rpassword
			session[:pwr] = "Passwords does not match!"
			redirect '/register'
		else
		
			db = SQLite3::Database.open('db/login.sqlite')

			@existing_usernames = db.execute("SELECT Username FROM users")

			i = 0
			while i != @existing_usernames.length
				if @existing_usernames[i][0] == username
					i = @existing_usernames.length - 1
					puts "Username already exists"
					@exist_user = true
				elsif @existing_usernames[i] = nil 
					@exist_user = false
					i = @existing_usernames.length - 1
				else
					@exist_user = false
					puts "Username dosent exist"
				end
				i+=1
			end

			if @exist_user == false	
				hash = BCrypt::Password.create(password)
				db.execute("INSERT INTO users(Hash, Username, permission) VALUES (?, ?, ?) ", [hash, username, 0])	
				redirect '/login'
			elsif @exist_user == true
				redirect '/register'
			end
		end	
		
	end

	post '/login' do
		session.destroy 
		username = params['username']
		password = params['password']

		db = SQLite3::Database.open('db/login.sqlite')
		@existing_user = db.execute("SELECT Username, Hash FROM users WHERE Username = ?", [username])

		if @existing_user == nil || @existing_user.empty?
			session[:login_fail] = "Wrong username or password, Please try again"
			redirect '/login'
		elsif @existing_user[0][0] == username && BCrypt::Password.new(@existing_user[0][1]) == password
			session[:user] = @existing_user[0][0]
			@permission = db.execute('SELECT permission FROM users WHERE Username = ?', @existing_user[0][0])
			session[:adminlevel] = @permission.first[0]
			redirect '/index'
		else
			redirect '/error'
		end
		
	end

	post '/changepermission' do

		newpermission = params['simple'].to_i
		userid = params['value']

		redirect '/index'
	end

	post '/logout' do 
		session.destroy
		redirect '/login'
	end

	

end