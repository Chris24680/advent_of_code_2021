input = File.readlines('input.txt').map(&:split).each{|x| x[1] = x[1].to_i }
depth = 0
horizontal = 0

input.each{ |key,value| 
    case key
    when "forward"
        horizontal += value
    when "down"
        depth += value
    when "up"
        depth -= value
    end
}

puts depth*horizontal

aim = 0
depth = 0
horizontal = 0
input.each{ |key,value| 
    case key
    when "forward"
        horizontal += value
        depth += aim * value
    when "down"
        aim += value
    when "up"
        aim -= value
    end
}

puts depth*horizontal