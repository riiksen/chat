struct PermissionSet
  
  @permissions : Array(Permission)
  
  def initialize(@permissions : Array(Permission))
    
  end
  
  def add_permission(permission : Permission)
    
  end  
  
  def del_permission(permission : Permission)
  
  end

  def >=(that : PermissionSet)
    
  end
end

struct Permission
  
end
