require 'byebug'


class Board
    require 'matrix'

    def initialize(values)
        @values = values
        @dabs = Array.new(5).map{Array.new(5)}
        @last_ball = nil
    end

    def dab(ball)
        location = Matrix[*@values].index(ball)
        if location
            byebug unless @dabs[location[0]]
            @dabs[location[0]][location[1]] = true 
            @last_ball = ball
        end
    end

    def bingo?
        if @dabs.detect{ |row| row.all?(true) } || @dabs.transpose.detect{ |column| column.all?(true) }
            return true
        end
    end

    def score
        @values
            .flatten
            .each_with_index
            .select{ |value, index| !@dabs.flatten[index] }
            .map{|x| x[0]}
            .sum * @last_ball
    end
end

class Bingo
    def initialize(input)
        @bingo_balls = input.first.split(",").map(&:to_i)
        @boards = input[1..-1].select{|x| x.length > 0}.map{|x| x.split.map(&:to_i) }.each_slice(5).map{|x| Board.new(x) }
    end

    def first_winning_board
        winner = nil
        @bingo_balls.each{ |ball|
            @boards.each{ |board| board.dab(ball) }
            winner = @boards.detect{ |board| board.bingo? }
            break if winner
        }

        puts "First winner #{winner.score}"
    end

    def last_winning_board
        candidates = @boards.dup
        @bingo_balls.each{ |ball|
            candidates.each{ |board| board.dab(ball) }
            if candidates.length != 1
                candidates.reject!{ |board| board.bingo? }
            else
                break if candidates.first.bingo?
            end
        }
        puts puts "Last winner #{candidates.first.score}"
    end
end

#process input
input = File.readlines('input.txt', chomp: true)
bingo = Bingo.new(input)
bingo.first_winning_board
bingo.last_winning_board

