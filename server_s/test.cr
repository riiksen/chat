require "json"
data = JSON.parse(%({"username":"Mike","uid":"123ubauih1u23hi1uh"}))

data.each do |key, value|
  case key
  when "username"
    puts value
  when "uid"
    puts value
  when "data"
    puts value
  end
end
