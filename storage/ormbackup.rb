require 'byebug'

class User < Grillkorv
    attr_reader :id, :username, :hash, :permission 

    #i subklasserna
    table_name "users"
    column 'id', 'integer'
    column 'username', 'string'
    column 'hash', 'string'
    column 'permission', 'integer'


    def initialize(user_array)
        @id = user_array[0]
        @username = user_array[1]
        @hash = user_array[2]
        @permission = user_array[3]
        
    end

    #i basklassen
    def self.table_name(string)
        @table_name = string
    end

    #i basklassen
    def self.column(name, type, required)
        @columns ||= {}
        @columns[name] = type
    end



    # User.one({id: })
    # User.one({username: "senap@grillkorv.com", last_login_date: Date.today})
    # UserContent.one({user_id: 1})

    # User.one('id', 1)
    def self.one(column, value)

        db = SQLite3::Database.open('db/login.sqlite')
        if user.to_i.to_s == user
            result_from_db = db.execute("SELECT * FROM #{@table_name} WHERE #{column} = ?", value)
        else
            result_from_db = db.execute("SELECT * FROM users WHERE username = ?", [user])
        end

        return self.new(result_from_db.first)
    end

    def self.from_array(array)
        return array.map { |res| self.new(res) }
    end

    def self.all
        db = SQLite3::Database.open('db/login.sqlite')
        result_from_db2 = db.execute("SELECT * FROM users")
        
        return self.from_array(result_from_db2)
    end
end

class Usercontent
    attr_reader :Userid, :content, :contentid

    def initialize(user_array)
        @Userid = user_array[0]
        @content = user_array[1]
        @contentid =  user_array[2]
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
        return self.from_array(result_from_db)
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

    def self.all(id)
        db = SQLite3::Database.open('db/login.sqlite')
        result_from_db = db.execute("SELECT * FROM sharedcontent WHERE sharedto_userid = ?", [id])
        return self.from_array(result_from_db)
    end

end

