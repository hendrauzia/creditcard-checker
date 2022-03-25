require_relative '../spec_helper.rb'

describe CreditCardSlot do
  before :each do
    @cc_one = "4111-1111-1111-1111"
    @no_placeholder = CreditCardSlot.new(@cc_one)
    @one_placeholder = CreditCardSlot.new("4111-1111-1111-11?2")
    @two_placeholders = CreditCardSlot.new("4111-1?11-1111-11?2")
    @three_placeholders = CreditCardSlot.new("41?1-1111-1?11-11?2")
    @four_placeholders = CreditCardSlot.new("41?1-?111-1?11-11?2")
    @five_placeholders = CreditCardSlot.new("41?1-?111-1?11-11??")

    @valid = @no_placeholder
    @invalid = CreditCardSlot.new("4111-1111-1111-1112")
  end

  describe "#new" do
    it "count for question mark (?) placeholder" do
      @no_placeholder.placeholder.should eql 0
      @one_placeholder.placeholder.should eql 1
      @two_placeholders.placeholder.should eql 2
      @three_placeholders.placeholder.should eql 3
      @four_placeholders.placeholder.should eql 4
    end
  end

  describe "#permutations" do
    it "permutates (0..9) range based on placeholder count" do
      @no_placeholder.permutations.should eql (0..9).to_a.permutation(0).to_a
      @one_placeholder.permutations.should eql (0..9).to_a.permutation(1).to_a
      @two_placeholders.permutations.should eql (0..9).to_a.permutation(2).to_a
      @three_placeholders.permutations.should eql (0..9).to_a.permutation(3).to_a
      @four_placeholders.permutations.should eql (0..9).to_a.permutation(4).to_a
    end
  end

  describe "#replace_placeholder" do
    it "replace (?) question mark placeholder" do
      @no_placeholder.replace_placeholder([1,2,3,4]).should eql @cc_one
      @one_placeholder.replace_placeholder([1,2,3,4]).should eql "4111-1111-1111-1112"
      @two_placeholders.replace_placeholder([1,2,3,4]).should eql "4111-1111-1111-1122"
      @three_placeholders.replace_placeholder([1,2,3,4]).should eql "4111-1111-1211-1132"
      @four_placeholders.replace_placeholder([1,2,3,4]).should eql "4111-2111-1311-1142"
    end
  end

  describe "#valid_cards" do
    it "returns 1 if no question mark placeholder is found and is valid" do 
      @valid.valid_cards.should eql 1
      @invalid.valid_cards.should eql 0
    end

    it "calculates the number of valid cards if question mark placeholder is found" do
      @one_placeholder.valid_cards.should eql 1
      @two_placeholders.valid_cards.should eql 8
      @three_placeholders.valid_cards.should eql 70
      @four_placeholders.valid_cards.should eql 510
    end

    it "returns invalid message if question mark placeholder is more than 4" do
      @five_placeholders.valid_cards.should eql "Question mark (?) placeholder maximum is 4!"
    end
  end
end