require "minefield/version"
require 'ostruct'

Struct.new("Mine", :x, :y, :r)

class Minefield
  def initialize(mines)
    @mines = mines.map {|m| 
      Struct::Mine.new(m[0], m[1], m[2])
    }
  end

  def explode(mine)
    mines = [mine]
    mines = mines.map { |m| Struct::Mine.new(m[0], m[1], m[2]) }
    recursive_explode(mines)
  end

  private

  def recursive_explode(mines)
    @mines.delete_if { |m| 
      mines.include?(m)
    }
    nearby = mines.map {|m| find_nearby(m)}.flatten.uniq
    total = mines.size
    total += recursive_explode(nearby) if nearby.size > 0
    total
  end

  def find_nearby(mine)
    nearby = @mines.select {|m| 
      Math.hypot(m[:x]-mine[:x], m[:y] - mine[:y]) <= mine[:r]
    }
    nearby.delete(mine)
    nearby
  end

  def self.explode_all(field)
    all_bombs = {}
    field.each do |f|
      minefield = new(field)
      total = minefield.explode(f)
      all_bombs[f] = total
    end
    all_bombs.sort_by { |_, v| v }

  end
  
end
