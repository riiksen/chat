struct User
  property username
  getter c_room, conn, voice, id, sid

  @username : String
  @id : String
  @conn : Connection
  @c_room : Room?
  @sid : Int32?
  @uid : String
  @permissions : NamedTuple(join_power: Permission)

  def initialize(@conn : Connection, user_params : JSON::Any, @permissions)
    user_params.each do |key, value|
      case key
      when "username"
        @username = value.as_s
      when "id"
        @id = value.as_s
      when "uid"
        @uid = value.as_s
        
      end
    end
  end

  # def initialize(@connection : Connection, user_params : JSON::Any, @permissions)
  #   user_params.each do |key, value|
  #     case key
  #     when "username"
  #       @username = value.as_s
  #     when "id"
  #       @id = value.as_s
  #     when ""
  #     end
  #   end
  # end

  # def finalize
  #   @conn.socket.close
  # end

  def check_params(user_params : JSON::Any) : Bool
    user_params.each do |key, value|
      case key
      when "username"
        raise ParamsError unless value.is_a(String)
      when "id"
        raise ParamsError unless value.is_a(String)
      end
    end
    true
  end

  def change_room(room : Room)
		self.c_room = room if self.join room
  end

  def join(room : Room)
    if self.permissions[:join_power] >= room.required_permissions[:join_power]
  
    end
  end
  
  class ParamsError < Exception; end
  
end


@[Flags]
enum User::Params
  Hidden
end
