require "spec_helper"
require 'minefield'
RSpec.describe Minefield do

  let(:field)  {
    {
      [3,2,3] =>  8,
      [4,4,1] => 8,
      [4,5,3] => 8,
      [3,7,5] => 8,
      [4,8,3] => 8,
      [7,3,1] => 10,
      [6,9,1] => 1,
      [7,11,1] => 1,
      [4,11,2] => 2,
      [5,12,1] => 1,
      [5,14,3] => 2,
      [7,2,4] => 10
    }
  }


  it "has a version number" do
    expect(Minefield::VERSION).not_to be nil
  end

  it "determines number of explosions" do
    field.each do |mine, expected|
      @minefield = Minefield.new(field.keys)
      expect(@minefield.explode(mine)).to eql(expected)
    end
  end

  it "returns a sorted list" do
    expect(Minefield.explode_all(field.keys)).to eql(field.sort_by {|k, v| v })
  end

end
