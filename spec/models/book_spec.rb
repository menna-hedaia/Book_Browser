require 'spec_helper'

describe Book do
	before(:each) do
      @book =  FactoryGirl.create (:book)
  end
	it "should respond to attributes" do
  		expect(@book).to respond_to(:title)
  		expect(@book).to respond_to(:author)
  		expect(@book).to respond_to(:publisher)
  end
  it "should not have empty title" do
     @book.title = ""
     expect(@book).to_not be_valid
  end	
end
