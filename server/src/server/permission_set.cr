struct PermissionSet

  
  @permissions : Array(Permission)
	@join_power : Int32
  
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

	def ==(that : Permission)

	end

	def !=(that : Permission)

	end

	def <(that : Permission)

	end

	def >(that : Permission)

	end

	def <=(that : Permission)

	end

  def >=(that : Permission)

	end
end
