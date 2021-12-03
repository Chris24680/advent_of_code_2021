input = File.readlines('input.txt', chomp: true).map(&:chars)
gamma = []
epsilon = []


input.first.length.times{ |index| 
    count_zero = 0
    count_one = 0

    input.each{ |x| 
        count_zero += 1 if x[index]=="0" 
        count_one += 1 if x[index]=="1" 
    }
    if count_zero > count_one
        gamma.push("0")
        epsilon.push("1")
    else
        gamma.push("1")
        epsilon.push("0")
    end
}

p gamma.join.to_i(2) * epsilon.join.to_i(2)

#task 2
oxygen = []
co2 = []


def oxygen_value(input, index=0)
    return input.join.to_i(2) if input.length == 1

    count_zero, count_one = count_bits_at_index(input, index)

    if count_zero > count_one
        oxygen_value(remove_values_with_bit_at_index("1", index, input), index+1)
    else
        oxygen_value(remove_values_with_bit_at_index("0", index, input), index+1)
    end
end

def co2_value(input, index=0)
    return input.join.to_i(2) if input.length == 1

    count_zero, count_one = count_bits_at_index(input, index)

    if count_zero > count_one
        co2_value(remove_values_with_bit_at_index("0", index, input), index+1)
    else
        co2_value(remove_values_with_bit_at_index("1", index, input), index+1)
    end
end

def count_bits_at_index(input, index)
    count_zero = 0
    count_one = 0

    input.each{ |x| 
        count_zero += 1 if x[index]=="0" 
        count_one += 1 if x[index]=="1" 
    }

    return count_zero, count_one
end

def remove_values_with_bit_at_index(bit, index, input)
    input.select{ |x| x[index] != bit }
end

puts oxygen_value(input) * co2_value(input)
