class CreditCardSlot
  attr_reader :placeholder, :number

  def initialize number
    @number = number
    @placeholder = @number.count "?"
    @valid_cards = valid_cards
  end

  def permutations
    (0..9).to_a.permutation(@placeholder).to_a
  end

  def replace_placeholder(values)
    @number.gsub(/\?/) { |_| values.shift }
  end

  def valid_cards
    if @valid_cards.nil?
      return "Question mark (?) placeholder maximum is 4!" if @placeholder > 4

      count = "0"
      if @placeholder.zero?
        count.succ! if CreditCard.new(@number).valid?
      else
        permutations.each do |combination|
          number = replace_placeholder(combination)
          count.succ! if CreditCard.new(number).valid?
        end
      end

      count.to_i
    else
      @valid_cards
    end
  end
end
