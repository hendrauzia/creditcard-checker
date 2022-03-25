require_relative '../../spec_helper.rb'

describe String do
  describe "#integer?" do
    it "checks if the whole string is an integer" do
      "123".integer?.should be_true
      "1.2".integer?.should be_false
      "12a".integer?.should be_false
      "a23".integer?.should be_false
      "abc".integer?.should be_false
    end

    it "checks for integer sign" do
      "+12".integer?.should be_true
      "-12".integer?.should be_true
      "+-1".integer?.should be_false
      "-+1".integer?.should be_false
      "1+2".integer?.should be_false
      "1-2".integer?.should be_false
      "12+".integer?.should be_false
      "12-".integer?.should be_false
      "1-+".integer?.should be_false
      "1+-".integer?.should be_false
    end

    it "checks from start and end of string" do
      "123".integer?.should be_true
      "abc".integer?.should be_false
      "123\nabc".integer?.should be_false
      "abc\n123".integer?.should be_false
    end
  end
end