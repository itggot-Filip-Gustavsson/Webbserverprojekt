require 'byebug'

class Joinedcontent < Orm
    attr_reader :sharedby, :id, :sharedto_userid, :userid, :content, :id

     table_name "sharedcontent" 
    column 'sharedby' #, 'integer'
    column 'id'#, 'integer'
    column 'sharedto_userid'#, 'integer'
    column 'userid'
    column 'content'
    column 'id'

    def initialize(user_array)
        @sharedby = user_array[0]
        @id = user_array[1]
        @sharedto_userid = user_array[2]
        @userid = user_array[3]
        @content = user_array[4]
        @id = user_array[5] 
    end

end