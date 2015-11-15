require 'spec_helper'

describe SessionsController do
render_views

  describe "#new" do
    before { get :new}
    it "returns http success" do

      assert_response :success
    end

    it "should have right title" do
      assert_select "title","Book Browser | SignIn"
    end

    it "should have right content" do
      assert_select "h1" , "Sign In"
    end
  end

  describe "#create" do
    
    before(:each) do
      post :create, :session => {email: "" , password: ""}
    end
    describe "invalid info" do
    it "should have right title" do
      assert_select "title","Book Browser | SignIn"
    end
     
    it "should have flash msg" do
      response.should render_template 'new'
      expect(flash[:notice]).to be_present

    end  
   end

  describe "valid info" do
    let(:user) {FactoryGirl.create(:user)}
    before do
       post :create, :session => {email: user.email , password: user.password}
    end
    
    it "should have successful signin" do
      expect(response).to redirect_to(books_path)
      expect(flash[:notice]).to be_present
    end 
   end 

  describe "valid info but not admin" do
   let(:user) {FactoryGirl.create(:user)}
   before do
      user.update_attribute(:admin , false)
      post :create, :session => {email: user.email , password: user.password}
      
    end

    it "should not accept nonadmin" do
        response.should render_template 'new'
        expect(flash[:notice]).to be_present

    end 
  end    
 end

 describe "#destroy" do
  let(:user) {FactoryGirl.create(:user)}
  before do
    post :create, :session => {email: user.email , password: user.password}
    delete :destroy
  end
  it "should signout" do
    response.should render_template 'static_pages/home'
     
  end 

 end 

end
