module MicroD20

  class Dice
    attr_accessor :side

    def initialize(side)
      @side = side
    end

    def roll(number, modifier=0)
      number = number
      total = 0
      number.times {total += rand(@side) + 1}
      total = total + modifier
      return total
    end
  end

  class Game < Array
    def initialize
      Array.new
    end

    def lineup(party_number=2)
     party_number.times {self << MicroD20::Player.new }
    end

    def sort_by_init
      self.each {|x| x.init = x.dex_bonus + MicroD20::Dice.new(20).roll(1)}
      self.sort! { |low, high| high.init <=> low.init}
    end
  end

  class Player
    attr_accessor :dex, :dex_bonus, :init

    def initialize
      @dex = MicroD20::Dice.new(6).roll(3)
      @dex_bonus = (@dex - 10)/2
      @init = 0
    end
  end
end
