require 'spec_helper'

describe User do
  before(:each) do
  	@user = FactoryGirl.create(:user)
  end

  it "should respond to attributes" do
  	expect(@user).to respond_to(:name)
  	expect(@user).to respond_to(:email)
  	expect(@user).to respond_to(:password)
  	expect(@user).to respond_to(:remember_token)
  	expect(@user).to respond_to(:admin)
  end
  it "should be valid" do
  	expect(@user).to be_valid
  end

describe "name" do
	before {@user.name = ""}
	it "should be present" do
	    @user.should_not be_valid
	end
end

describe "password" do
	before {@user.password = ""}
	it "should be present" do
	    @user.should_not be_valid
	end
end

describe "email" do
	before {@user.email = ""}
	it "should be present" do
	  expect(@user).not_to be_valid
	end

	it "should not be valid if wrong format" do
		address =  %w[user@foo,com user_at_foo.org example.user@foo.foo@bar_baz.com foo@bar+bar.com]
		address.each do |invalid_add|
			@user.email = invalid_add
            expect(@user).not_to be_valid
        end     
	end 
	
	it "should be valid if correct format" do
		address =  %w[user@foo.COM A_US-ER@f.b.org]
		address.each do |valid_add|
			@user.email = valid_add
            expect(@user).to be_valid
        end  

	end

	it "should not accept duplicate email" do 
       userd = @user.dup
       userd.email = @user.email.upcase
       userd.save
       expect(userd).to_not be_valid
	end 
end

describe "authenticate" do
	let (:found_user) {User.find_by_email(@user.email)}
	let (:invalid_user) {found_user.authenticate("invalid")}
	it"should respond to method" do
       expect(@user).to respond_to(:authenticate)
	end

	it "should get user with correct password" do   
       expect(found_user).to eq (found_user.authenticate(@user.password))
	end

	it "should reject user with wrong password" do
		
		expect(invalid_user).not_to eq found_user
		expect(invalid_user).to be_false

	end	
end	
end
