struct Connection

  @socket : TCPSocket
  @voice : UDPSocket

  def initialize(@socket)

  end
end