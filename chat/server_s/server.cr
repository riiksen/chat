require "socket"

struct Client
  property username : String
  getter socket : TCPSocket

  def initialize(@username : String, @socket : TCPSocket); end
end

struct Room
  property name : String
  getter id : Int32
  getter users : Array(Client) = [] of Client
  property hidden : Bool

  def initialize(@name : String, @id : Int32, @hidden = false)
  end

  def add_user(client : Client)
    self.users << client
  end
end

struct User
  property username : String
  getter client : Client
  getter id : UInt32
  getter room : Room

  def initialize(@username : String, @client : Client, @id : UInt32); end

  def change_room(room : Room)
    self.room = room unless room == self.room
  end
end

# struct Command
#   def initialize(); end
# 
#   def call()
# 
#   end
# end

class Server
  def initialize(port)
    @server = TCPServer.new("127.0.0.1", port)
    @rooms = [] of Room
    @clients = [] of Client
    @users = [] of User
    run
    admin
  end

  def admin
    loop do
      puts gets
      case gets
      when "users"
        # @users.each
        @clients.each do |client|
          puts "#{client.username} => #{client.room.name}"
        end
      end
    end
  end

  def run
    spawn { loop { spawn handle_conn(@server.accept) } }
  end

  def handle_conn(conn)
    conn.puts "Podaj swoją nazwę użytkownika"
    username = conn.read_line.to_s.chomp
    @clients.each do |other_client|
      if username == other_client.username
        conn.puts "Ta nazwa użytkownika jest już używana"
        return
      elsif username.empty?
        conn.puts "Nazwa użytkownika nie może być pusta"
        return
      end
    end
    @clients.push(client = Client.new(username, conn))
    @users.push(user = User.new(username, conn))
    puts "#{conn.remote_address} connected, username: #{username}"
    handle_user(client)
  rescue IO::EOFError
    puts "#{conn.remote_address} disconnected"
    conn.close
  end

  def handle_user(user : User)
    loop do
      msg = client.socket.gets.to_s.chomp
      puts "#{client.username}: #{msg}" if DEBUG
      if msg.strip[0] == '!'
        cmd = msg.strip.split(' ')
        puts "cmd: #{cmd}, cmd[0]: #{cmd[0]}" if DEBUG
        case cmd[0].downcase
        when "!help"
          client.socket.puts <<-HELP
          asdf asdf asdf
          HELP
        when "!users"

        when "!rooms"
        when "!whois"
          users = @users.select { |e| e.username == cmd[2] }
          client.socket.puts <<-ASDF
            Records found #{users.size}
          ASDF
          users.each do |user|
            client.socket.puts <<-ASDF
              #{user.username}: 
            ASDF
          end
        when "!cr"

        when "!disconnect", "!dc"
          @clients.delete(client)
          client.socket.close
        else

        end
      else
        @clients.each do |other_client|
          unless client == other_client
            other_client.socket.puts "#{client.username}: #{msg}"
          end
        end
      end
    end
  rescue IO::EOFError | IO::Error
    @clients.reject! { |other_client| other_client.username == client.username}
    puts "Client #{client.username}"
    client.socket.close
  end

  def handle_user(client : Client)
    loop do
      msg = client.socket.gets.to_s.chomp
      puts "#{client.username}: #{msg}" if DEBUG
      if msg.strip[0] == '!'
        cmd = msg.strip.split(' ')
        puts "cmd: #{cmd}, cmd[0]: #{cmd[0]}" if DEBUG
        case cmd[0].downcase
        when "!help"
          client.socket.puts <<-HELP
          asdf asdf asdf
          HELP
        when "!users"

        when "!rooms"
        when "!whois"
          users = @users.select { |e| e.username == cmd[2] }
          client.socket.puts <<-ASDF
            Records found #{users.size}
          ASDF
          users.each do |user|
            client.socket.puts <<-ASDF
              #{user.username}: 
            ASDF
          end
        when "!cr"

        when "!disconnect", "!dc"
          @clients.delete(client)
          client.socket.close
        else

        end
      else
        @clients.each do |other_client|
          unless client == other_client
            other_client.socket.puts "#{client.username}: #{msg}"
          end
        end
      end
    end
  rescue IO::EOFError | IO::Error
    @clients.reject! { |other_client| other_client.username == client.username}
    puts "Client #{client.username}"
    client.socket.close
  end
end

Server.new(2000)