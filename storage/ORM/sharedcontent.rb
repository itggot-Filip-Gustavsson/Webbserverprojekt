require 'byebug'

class Sharedcontent < Orm
    attr_reader :sharedby, :id, :sharedto_userid

    table_name "sharedcontent"
    column 'sharedby' #, 'integer'
    column 'id'#, 'integer'
    column 'sharedto_userid'#, 'integer'


    def initialize(user_array)
        @sharedby = user_array[0]
        @id = user_array[1]
        @sharedto_userid = user_array[2]

    end

end