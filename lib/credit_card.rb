class CreditCard
  attr_reader :number

  def initialize value
    @number = value.to_s.strip.tr("-", "")
    @valid  = valid?
  end

  def valid?
    if @valid.nil?
      @number.length == 16 ? luhn? : false
    else
      @valid
    end
  end

  def luhn?
    if @number.integer?
      ((@number.reverse.chars.map.with_index do |n, i|
        if i.odd?
          num = n.to_i * 2
          num > 9 ? num.to_s.chars.map{ |n| n.to_i }.sum : num
        else
          n.to_i
        end
      end).sum % 10).zero?
    else
      false
    end
  end
end