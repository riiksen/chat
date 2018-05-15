require "socket"
require "db"
require "sqlite3"
require "json"
# require "habitat"

# require "user"
# require "room"
require "server/**"

class Server

  @server : TCPServer
  @rooms : Array(Room) = [] of Room
  @users : Array(User) = [] of User

  def initialize(port, db_url)
    @server = TCPServer.new("127.0.0.1", port)
    @db = DB.open db_url
    db_get_rooms
    spawn run
    admin
  end

  def admin
    loop do
      case gets
      when "users"
        @users.each do |user|
          puts "#{client.username} => #{client.room.name}"
        end
      end
    end
  end

  def run
    spawn { loop { spawn conn_routine(@server.accept) } }
    loop do
      
    end
  end

  def conn_routine(conn)
    conn.puts "tping"
    unless conn.gets.to_s.chomp == "tpong"
      conn.close
      return
    end
    conn.puts "up?" # Request User Params
    user_params = conn.gets
    # {
    # "username": "asdf",
    # "uid": "asda12easdnb1872heuads"
    # }
    begin
      user_params = JSON.parse(user_params)
      User.check_params(user_params)
    rescue
      conn.puts "nope"
      conn.close
      return
    end
    # rs = @db.query_one? "select uid from users where uid = ?", data["uid"], as: String
    puts "#{conn.remote_address} connected, username: #{user_params[:username]}, uid: #{user_params[:uid]}"
    @users.push(user = User.new(conn, user_params))
    handle_user(user)
  rescue IO::EOFError
    puts "#{conn.remote_address} disconnected"
    conn.close
  end

  def handle_user(user : User)
    loop do
      msg = user.socket.gets.to_s.chomp
      puts "#{user.username}: #{msg}" if DEBUG
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
          room = @rooms.find { |elm| elm.name == cmd[2] }
          user.chan
        when "!disconnect", "!dc"
          @users.delete(client)
          client.socket.close
        else

        end
      else
        @users.each do |other_client|
          unless client == other_client
            other_client.socket.puts "#{client.username}: #{msg}"
          end
        end
      end
    end
  rescue IO::EOFError | IO::Error
    @users.reject! { |other_client| other_client.username == client.username}
    puts "Client #{client.username}"
    client.socket.close
  end

  private def db_get_rooms

  end
end

Server.new(2000, "sqlite3:./db.db")
