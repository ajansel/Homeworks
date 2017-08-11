require 'rspec'
require 'dessert'

=begin
Instructions: implement all of the pending specs (the `it` statements without blocks)! Be sure to look over the solutions when you're done.
=end

describe Dessert do
  let(:chef) { double("chef", name: "AJ") }
  #The third argument, the name, should be a chef not a string
  subject(:brownie) { Dessert.new('brownie', 50, chef)}


  describe "#initialize" do
    it "sets a type" do
      expect(brownie.type).to eq('brownie')
    end

    it "sets a quantity" do
      expect(brownie.quantity).to eq(50)
    end

    it "starts ingredients as an empty array" do
      expect(brownie.ingredients).to be_empty
    end

    it "raises an argument error when given a non-integer quantity" do
      expect { Dessert.new('bronie', '50', chef) }.to raise_error(ArgumentError)
    end
  end

  describe "#add_ingredient" do
    it "adds an ingredient to the ingredients array" do
      brownie.add_ingredient('milk')
      expect(brownie.ingredients).to include('milk')
    end
  end

  describe "#mix!" do
    it "shuffles the ingredient array" do
      brownie.add_ingredient('eggs')
      brownie.add_ingredient('chocolate mix')
      brownie.add_ingredient('butter')
      #Make sure our ingredients were added
      expect(brownie.ingredients).to eq(['eggs', 'chocolate mix', 'butter'])

      #Now mix them up
      brownie.mix!

      #It should be reorderd
      expect(brownie.ingredients).to_not eq(['eggs', 'chocolate mix', 'butter'])

      #Make sure we still have an array containing the elements it should
      expect(brownie.ingredients.sort).to eq(['eggs', 'chocolate mix', 'butter'].sort)
    end
  end

  describe "#eat" do
    it "subtracts an amount from the quantity" do
      brownie.eat(20)
      expect(brownie.quantity).to eq(30)
    end

    it "raises an error if the amount is greater than the quantity" do
      expect { brownie.eat(51) }.to raise_error("not enough left!")
    end
  end

  describe "#serve" do
    it "contains the titleized version of the chef's name" do
      #Here we need to use an 'allow' so that we ALLOW chef to receive and return to simulate a chef class
      #This is when we are using the return value of another class
      allow(chef).to receive(:titleize).and_return("Chef AJ the Great Baker")

      expect(brownie.serve).to eq("Chef AJ the Great Baker has made 50 brownies!")
    end
  end

  describe "#make_more" do
    it "calls bake on the dessert's chef with the dessert passed in" do
      #Here we need to use an 'expect' because we are EXPECTING chef to do so to make sure our method is properly functioning
      #This is when we are making sure we call on another class
      expect(chef).to receive(:bake).with(brownie)
      brownie.make_more
    end
  end
end
