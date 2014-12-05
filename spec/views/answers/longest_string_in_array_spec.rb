require "./spec/spec_helper"
require 'rails_helper'

RSpec.describe Answer, :type => :model do
  describe 'longest string in array' do
    let(:array_1) { [1, 2, 3, 4, 5, 5, 7] }
    let(:array_2) { [4, 4, 5, 5, 6, 6, 6, 7] }
    let(:array_3) { [7, 4, 3, 5, 6, 2, 6, 4] }
    let(:array_4) { ["apple", "cherry", "banana"]}

    it "is defined as a method" do
      expect(defined?(get_longest_string)).to eq('method')
    end

    it "requires a single argument" do
      expect(method(:get_longest_string).arity).to eq(1)
    end

    it "returns the correct get_longest_string of an odd-length array" do
      expect(get_longest_string(array_1)).to eq(4)
    end

    it "returns the correct get_longest_string of an even-length array" do
      expect(get_longest_string(array_2)).to eq(5.5)
    end

    it "returns the correct get_longest_string for an unsorted array" do
      expect(get_longest_string(array_3)).to eq(4.5)
    end

    it "returns the correct get_longest_string for an array filled with strings **BONUS**" do
      expect(get_longest_string(array_4)).to eq("banana")
    end

  end
end