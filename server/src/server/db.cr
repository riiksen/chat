class Db
  getter handle

  @@handle : DB::Connection?

  def connect(addr : String)
    raise AlreadyConnectedError if @@handle

  end

  def disconnect

  end

  class AlreadyConnectedError < Exception; end
end
