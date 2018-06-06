class Db
  getter handle

  @@handle : DB::Conenction?

  def connect(addr : String)
    raise AlreadyConnectedError if @@handle

  end

  def disconnect

  end

  class AlreadyConnectedError < Error; end
end