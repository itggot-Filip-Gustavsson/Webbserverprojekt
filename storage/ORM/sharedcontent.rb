require 'byebug'

class Sharedcontent < Orm
    attr_reader :sharedby, :sharedcontentid, :sharedto_userid

    table_name "sharedcontent"
    column 'sharedby' #, 'integer'
    column 'sharedcontentid'#, 'integer'
    column 'sharedto_userid'#, 'integer'

    def initialize(user_array)
        @sharedby = user_array[0]
        @sharedcontentid = user_array[1]
        @sharedto_userid = user_array[2]
    end

end