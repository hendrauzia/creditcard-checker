require_relative '../../spec_helper.rb'

describe Array do
  describe "#sum" do
    it "calculate the total value of the content is numeric" do
      array = (1..3).to_a
      array.sum.should eql (1 + 2 + 3)
    end
  end
end
