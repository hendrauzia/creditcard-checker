class Wallet
  attr_reader :max, :cards

  def initialize(max)
    @max = max.to_i < 11 ? max.to_i : 10
    @cards = Array.new
  end

  def add(card)
    @cards << CreditCardSlot.new(card) if @cards.length < @max
  end
end
