
class Usercontent < Orm
    attr_reader :userid, :content, :id
    table_name "usercontent"
    column 'userid'#, 'integer'
    column 'content'#, 'string'
    column 'id'#, 'integer'

    def initialize(user_array)
        @userid = user_array[0]
        @content = user_array[1]
        @id =  user_array[2]
    end


end