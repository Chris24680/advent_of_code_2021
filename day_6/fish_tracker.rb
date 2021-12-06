# task 1 - Naive 

class Fish
    def initialize(internal_timer = 8)
        @internal_timer = internal_timer
    end

    def age_day
        if @internal_timer == 0
            @internal_timer = 6
            return Fish.new
        else 
            @internal_timer -= 1
            return nil
        end
    end

    def to_s
        @internal_timer.to_s
    end
end

school = File.readlines('input.txt', chomp: true).first.split(',').map(&:to_i).map{ |x| Fish.new(x) }

80.times { |day| 
    new_fish = school.map{|fish| fish.age_day }.compact
    school += new_fish
}

puts school.count

# task 2 - Improved

school = File.read('input.txt').split(',').map(&:to_i).tally
school.default = 0
256.times {
    school.transform_keys! { |x| x - 1 }
    school[8] = school[-1]
    school[6] += school[-1]
    school[-1] = nil
}

puts school.values.compact.sum