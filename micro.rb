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
    attr_accessor :dex, :dex_bonus, :str, :str_bonus, :wis, :wis_bonus, :init,
    :atk, :ac, :hp, :level, :exp

    def initialize
      @dex = MicroD20::Dice.new(6).roll(3)
      @str = MicroD20::Dice.new(6).roll(3)
      @wis = MicroD20::Dice.new(6).roll(3)
      @dex_bonus = (@dex - 10)/2
      @str_bonus = (@str - 10)/2
      @wis_bonus = (@wis - 10)/2
      @init = 0
      @ac = 10 + @dex_bonus
      @atk = @str_bonus
#hp needs some tweaking. Want random number of at least 1
      @hp = 8 + @str_bonus
      @level = 1
      @exp = 0
    end

    def hp_zero?
      self.hp <= 0
    end
  end
end
  
