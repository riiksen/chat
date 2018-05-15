struct Room
  property name
  getter p_room, users, room_flags

  @name : String
  @users : Array(User) = [] of User
  @p_room : Room
  @room_flags : Int32
  @type : Int32

  # 
  # 
  # 
  # 
  # 
  # 
  # 

  def initialize(@name : String, @room_flags : Int32, @type : Int32)

  end

  def add_user(user : User)
    @users << user
  end

  def del_user(user : User)
    @users.reject! { |r_user| r_user.sid == user.sid }
  end
end

enum Room::Type
  Text
  Voice
  VoiceText
end

@[Flags]
enum Room::Flags
  Hidden
end