require_relative '../spec_helper.rb'

describe CreditCard do
  describe "#new" do
    it "strip spaces on start and end of string" do
      CreditCard.new(" 123 ").number.should eql "123"
    end

    it "strip dashes within string" do
      CreditCard.new("123-456-789").number.should eql "123456789"
    end
  end

  describe "#luhn?" do
    it "validate against luhn algoritm" do
      CreditCard.new("1230").luhn?.should be_true
      CreditCard.new("1231").luhn?.should be_false
    end
    it "checks if string is integer" do
      CreditCard.new("abc").luhn?.should be_false
    end
  end

  describe "#valid?" do
    it "should be exactly 16 digit" do
      # invalid luhn with invalid length
      CreditCard.new("123").valid?.should be_false
      # valid luhn with invalid lengh
      CreditCard.new("1230").valid?.should be_false
      # valid luhn with valid length
      CreditCard.new("4111-1111-1111-1152").valid?.should be_true
    end
  end
end