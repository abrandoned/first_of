require 'spec_helper'

describe ::FirstOf do
  class SpecObject
    include ::FirstOf

    def callable; return lambda { "here" }; end
    def nothing; nil; end
    def selfie; self; end
    def something; true; end
    def symbol; :symbol; end
  end

  context "#first_of" do
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

    context "[:symbol :symbol]" do
      it "returns the first symbolized argument that the object responds_to if the result is present" do
        test = SpecObject.new
        test.first_of([:selfie, :nothing]).should be_nil
      end

      it "returns the second symbolized argument that the object responds_to if the first is not present" do
        test = SpecObject.new
        test.first_of([:selfie, :something]).should be_true
      end

      it "returns a symbol if the first present value is a symbol" do
        test = SpecObject.new
        test.first_of([:selfie, :symbol]).should eq(:symbol)
      end

      it "does not throw an exception if the object does not respond to the symbol" do
        test = SpecObject.new
        expect { test.first_of([:selfie, :what]) }.to_not raise_error
      end
    end

    context "lambda {}, :symbol" do
      it "returns the first symbolized argument that the object responds_to if the result is present" do
        test = SpecObject.new
        test.first_of( -> { nil }, :nothing).should be_nil
      end

      it "returns the second symbolized argument that the object responds_to if the first is not present" do
        test = SpecObject.new
        test.first_of( -> { nil }, :something).should be_true
      end

      it "returns a symbol if the first present value is a symbol" do
        test = SpecObject.new
        test.first_of( -> { :symbol }, nil).should eq(:symbol)
      end

      it "does not throw an exception if the object does not respond to the symbol" do
        test = SpecObject.new
        expect { test.first_of( -> { nil }, :what) }.to_not raise_error
      end
    end

    context "2 => :symbol, 1 => :symbol" do
      it "prioritizes the return value by the hash key" do
        test = SpecObject.new
        test.first_of(2 => :selfie, 1 => :symbol).should eq(:symbol)
      end

      it "does not return the first hash key if not present" do
        test = SpecObject.new
        test.first_of(2 => :symbol, 1 => nil).should eq(:symbol)
      end

      it "returns a symbol if the first present value is a lambda that returns a symbol" do
        test = SpecObject.new
        test.first_of(1 => lambda { :selfie }, 2 => :symbol).should eq(:selfie)
      end

      it "does not throw an exception if the object does not respond to the symbol" do
        test = SpecObject.new
        expect { test.first_of(2 => :selfie, 1 => :what) }.to_not raise_error
      end
    end

    context "lambda {}, 2 => :symbol, 1 => :symbol" do
      it "prioritizes the lambda over the return value by the hash key" do
        test = SpecObject.new
        test.first_of(lambda { :lambda }, 2 => :selfie, 1 => :symbol).should eq(:lambda)
      end
    end
  end

  context "#first_of!" do
    context ":symbol, :symbol args" do
      it "returns the first symbolized argument that the object responds_to if the result is present" do
        test = SpecObject.new
        test.first_of!(:something, :nothing).should be_true
      end

      it "returns the second symbolized argument that the object responds_to if the first is not present" do
        test = SpecObject.new
        test.first_of!(:nothing, :something).should be_true
      end

      it "returns a symbol if the first present value is a symbol" do
        test = SpecObject.new
        test.first_of!(:nothing, :symbol).should eq(:symbol)
      end

      it "throws an exception if the object does not respond to the symbol" do
        test = SpecObject.new
        expect { test.first_of!(:nothing, :what) }.to raise_error
      end
    end

    context "[:symbol :symbol]" do
      it "returns the first symbolized argument that the object responds_to if the result is present" do
        test = SpecObject.new
        test.first_of!([:selfie, :nothing]).should be_nil
      end

      it "returns the second symbolized argument that the object responds_to if the first is not present" do
        test = SpecObject.new
        test.first_of!([:selfie, :something]).should be_true
      end

      it "returns a symbol if the first present value is a symbol" do
        test = SpecObject.new
        test.first_of!([:selfie, :symbol]).should eq(:symbol)
      end

      it "throws an exception if the object does not respond to the symbol" do
        test = SpecObject.new
        expect { test.first_of!([:selfie, :what]) }.to raise_error
      end
    end

    context "lambda {}, :symbol" do
      it "returns the first symbolized argument that the object responds_to if the result is present" do
        test = SpecObject.new
        test.first_of!( -> { nil }, :nothing).should be_nil
      end

      it "returns the second symbolized argument that the object responds_to if the first is not present" do
        test = SpecObject.new
        test.first_of!( -> { nil }, :something).should be_true
      end

      it "returns a symbol if the first present value is a symbol" do
        test = SpecObject.new
        test.first_of!( -> { :symbol }, nil).should eq(:symbol)
      end

      it "throws an exception if the object does not respond to the symbol" do
        test = SpecObject.new
        expect { test.first_of!( -> { nil }, :what) }.to raise_error
      end
    end

    context "2 => :symbol, 1 => :symbol" do
      it "prioritizes the return value by the hash key" do
        test = SpecObject.new
        test.first_of!(2 => :selfie, 1 => :symbol).should eq(:symbol)
      end

      it "does not return the first hash key if not present" do
        test = SpecObject.new
        test.first_of!(2 => :symbol, 1 => nil).should eq(:symbol)
      end

      it "returns a symbol if the first present value is a lambda that returns a symbol" do
        test = SpecObject.new
        test.first_of!(1 => lambda { :selfie }, 2 => :symbol).should eq(:selfie)
      end

      it "throws an exception if the object does not respond to the symbol" do
        test = SpecObject.new
        expect { test.first_of!(2 => :selfie, 1 => :what) }.to raise_error
      end
    end

    context "lambda {}, 2 => :symbol, 1 => :symbol" do
      it "prioritizes the lambda over the return value by the hash key" do
        test = SpecObject.new
        test.first_of!(lambda { :lambda }, 2 => :selfie, 1 => :symbol).should eq(:lambda)
      end
    end
  end

end
