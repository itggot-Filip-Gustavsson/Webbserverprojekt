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
      
        result_from_db = db.execute("SELECT * FROM #{@table_name} WHERE #{@column} = ?", value)
       
        if @table_name == 'usercontent'
            return self.from_array(result_from_db)
        else
            return self.new(result_from_db)
    end

    def self.from_array(array)
        return array.map { |res| self.new(res) }
    end

    def self.all
        db = SQLite3::Database.open('db/login.sqlite')
        result_from_db2 = db.execute("SELECT * FROM #{@table_name}")
        
        return self.from_array(result_from_db2)
    end
end


