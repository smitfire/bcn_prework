require "./spec/spec_helper"
require 'rails_helper'

RSpec.describe Answer, :type => :model do
  describe 'total' do
    let(:array_1) { [1, 2, 3, 4, 5, 5, 7] }
    let(:array_2) { [4, 4, 5, 5, 6, 6, 6, 7] }

    it "is defined as a method" do
      expect(defined?(total)).to eq('method')
    end

    it "requires a single argument" do
      expect(method(:total).arity).to eq(1)
    end

    it "returns the correct total of array 1" do
      expect(total(array_1)).to eq(27)
    end

    it "returns the correct total of array 2" do
      expect(total(array_2)).to eq(43)
    end
  end

end