require "socket"

# class Client
#   def initialize(ip, port)
#     @socket = TCPSocket.new(ip, port)
#     spawn listen
#     spawn send
#   end
# 
#   def listen
#     loop do
#       puts @socket.gets
#     end
#   end
# 
#   def send
#     loop do
#       msg = gets.to_s
#       @socket.puts(msg)
#     end
#   end
# end
# 
# Client.new("127.0.0.1", 20000)

socket = TCPSocket.new("127.0.0.1", 2000)

spawn { loop { puts socket.gets } }

loop { socket.puts gets.to_s }