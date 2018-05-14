

class Users < Orm
    attr_reader :id, :username, :hash, :permission

    table_name "users"
    column 'id'#, 'integer'
    column 'Username'#, 'string'
    column 'Hash'#, 'string'
    column 'permission'#, 'integer'

    def initialize(user_array2)
        user_array = user_array2.first
        @id = user_array[0]
        @username = user_array[1]
        @hash = user_array[2]
        @permission = user_array[3]
        
    end


end