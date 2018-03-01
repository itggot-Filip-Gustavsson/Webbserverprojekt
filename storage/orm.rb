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
        p result_from_db
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



