struct Room
  property name
  getter p_room, users, room_flags, type, user_blacklist, user_whitelist

  @name : String
  @users : Array(User) = [] of User
  @p_room : Room
  @room_flags : Int32
  @type : Int32
  @blacklist : Array(rule: String)
  @whitelist : Array(rule: String)
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
  
  # Blacklist user by the struct of this
  def add_user_to_blacklist(user : User)
    
  end
  
  # Blacklist user by his uuid (unique user identifier) 
  def add_user_to_blacklist(uuid : String)
    
  end
  
  def remove_user_from_blacklist(user : User)
    
  end
  
  def remove_user_from_blacklist(uuid : String)
    
  end
  
  def add_ip_to_blacklist(ip : String)
    
  end
  
  def add_ip_to_blacklist(ip : Socket::IPAddress)
    
  end
  
  def remove_ip_from_blacklist(ip : String)
    
  end
  
  def remove_ip_from_blacklist(ip : Socket::IPAddress)
    
  end
  
  # Whitelist user by the struct of this
  def add_user_to_whitelist(user : User)
    
  end
  
  # Blacklist user by his uuid (unique user identifier) 
  def add_user_to_whitelist(uuid : String)
    
  end
  
  def remove_user_from_whitelist(user : User)
    
  end
  
  def remove_user_from_whitelist(uuid : String)
    
  end
  
  def add_ip_to_whitelist(ip : String)
    
  end
  
  def add_ip_to_whitelist(ip : Socket::IPAddress)
    
  end
  
  def remove_ip_from_whitelist(ip : String)
    
  end
  
  def remove_ip_from_whitelist(ip : Socket::IPAddress)
    
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
  WhitelistEnabled
end
