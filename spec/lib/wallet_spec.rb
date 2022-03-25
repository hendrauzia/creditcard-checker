require_relative '../spec_helper.rb'

describe Wallet do
  before :each do
    @wallet = Wallet.new(3)
    @card = "4111-1111-1111-1111"
  end

  describe "#add" do
    it "adds credit card to collection" do
      @wallet.add(@card).length.should be 1
    end

    it "adds until maximum wallet size reached" do
      7.times { @wallet.add(@card) }
      @wallet.cards.length.should be 3
    end

    it "maximum wallet size is 10 cards" do
      Wallet.new(9).max.should be 9
      Wallet.new(20).max.should be 10
    end
  end
end