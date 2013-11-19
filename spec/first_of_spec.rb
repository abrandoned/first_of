require 'spec_helper'

describe ::FirstOf do
  class SpecObject
    include ::FirstOf

    def callable; return lambda { "here" }; end
    def nothing; nil; end
    def something; true; end
    def symbol; :symbol; end
  end

  context ":symbol, :symbol args" do
    it "returns the first symbolized argument that the object responds_to if the result is present" do
      test = SpecObject.new
      test.first_of(:something, :nothing).should be_true
    end

    it "returns the second symbolized argument that the object responds_to if the first is not present" do
      test = SpecObject.new
      test.first_of(:nothing, :something).should be_true
    end

    it "returns a symbol if the first present value is a symbol" do
      test = SpecObject.new
      test.first_of(:nothing, :symbol).should eq(:symbol)
    end

    it "does not throw an exception if the object does not respond to the symbol" do
      test = SpecObject.new
      expect { test.first_of(:nothing, :what) }.to_not raise_error
    end
  end

end
