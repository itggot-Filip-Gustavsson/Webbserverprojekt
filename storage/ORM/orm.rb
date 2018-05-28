require 'byebug'


class Orm

    def self.table_name(name)
        @table_name = name 
    end

    def self.column(name) #,type)
       # @column ||= {}
       # @column [name] = type
        @column = name
    end


    def self.one(column, value)

        db = SQLite3::Database.open('db/login.sqlite')
        
       
        result_from_db = db.execute("SELECT * FROM #{@table_name} WHERE #{column} = ?", value)
       
        if @table_name == 'users' 
            return self.new(result_from_db.first)
        else
           return self.from_array(result_from_db)
        end
    end

    def self.from_array(array)
        return array.map { |res| self.new(res) }
    end

    def self.all(column, value, jointable = nil)
        db = SQLite3::Database.open('db/login.sqlite')

        if jointable == nil

            
            result_from_db = db.execute("SELECT * FROM #{@table_name} WHERE #{column} = ?", value)
            
            return self.from_array(result_from_db)
        else 
           
            result_from_db = db.execute("SELECT * FROM #{@table_name} INNER JOIN #{jointable} on #{@table_name}.id = #{jointable}.id WHERE #{column} = ?", value)

            return self.from_array(result_from_db)
        end
    end

    def self.everything
        db = SQLite3::Database.open('db/login.sqlite')
        result_from_db = db.execute("SELECT * FROM #{@table_name}")
        
        return self.from_array(result_from_db)
    end

    def self.delete(column, value)
        db = SQLite3::Database.open('db/login.sqlite')
        db.execute("DELETE FROM #{@table_name} WHERE #{column} = ?", [value])
    end

    def self.insert(column, value1, value2)
        db = SQLite3::Database.open('db/login.sqlite')
        db.execute("INSERT INTO #{@table_name}(#{column}) VALUES (?, ?)", [value1, value2])
    end
end


