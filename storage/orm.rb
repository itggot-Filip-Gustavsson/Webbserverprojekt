require 'byebug'

class User
    attr_reader :id, :username, :hash, :permission 

    def initialize(user_array)
        @id = user_array[0]
        @username = user_array[1]
        @hash = user_array[2]
        @permission = user_array[3]
        
    end

    def self.one(user)
        db = SQLite3::Database.open('db/login.sqlite')
        if user.to_i.to_s == user
            result_from_db = db.execute("SELECT * FROM users WHERE id = ?", [user])
        else
            result_from_db = db.execute("SELECT * FROM users WHERE username = ?", [user])
        end

        return self.new(result_from_db.first)
    end

    def self.all
        db = SQLite3::Database.open('db/login.sqlite')
        result_from_db2 = db.execute("SELECT * FROM users")
        
        allusers = []
        result_from_db2.each do |result|
            allusers << self.new(result)
        end
       
        return allusers
    end
end

class Usercontent
    attr_reader :Userid, :content, :contentid

    def initialize(user_array)
        @Userid = user_array[0]
        @content = user_array[1]
        @contentid = user_array[2]
        p @content
    end

    def self.from_array(array)
        return array.map { |res| self.new(res) }
    end

    def self.all(userid)
        db = SQLite3::Database.open('db/login.sqlite')
        result_from_db = db.execute("SELECT * FROM usercontent WHERE Userid = ?", [userid])
        return self.from_array(result_from_db)
    end

    def self.one(id)
        db = SQLite3::Database.open('db/login.sqlite')
        result_from_db = db.execute("SELECT * FROM usercontent WHERE contentid = ?", [id])
        return self.new(result_from_db.first)
    end
end

class Sharedcontent
    attr_reader :sharedby, :sharedcontentid, :sharedto_userid

    def initialize(user_array)
        @sharedby = user_array[0]
        @sharedcontentid = user_array[1]
        @sharedto_userid = user_array[2]
    end

    def self.from_array(array)
        return array.map { |res| self.new(res) }
    end

    def self.one(id)
        db = SQLite3::Database.open('db/login.sqlite')
        result_from_db = db.execute("SELECT * FROM sharedcontent WHERE sharedto_userid = ?", [id])
        return self.from_array(result_from_db)
    end

end


