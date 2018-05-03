
class Usercontent < Orm
    attr_reader :id, :username, :hash, :permission

    table_name "usercontent"
    column 'Userid'#, 'integer'
    column 'content'#, 'string'
    column 'contentid'#, 'integer'

    def initialize(user_array)
        @Userid = user_array[0]
        @content = user_array[1]
        @contentid =  user_array[2]
    end

    def self.from_array(array)
        return array.map { |res| self.new(res) }
    end

end