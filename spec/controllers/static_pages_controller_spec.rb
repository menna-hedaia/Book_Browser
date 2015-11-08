
require 'spec_helper'

describe StaticPagesController do
render_views
  describe "Home page" do
    it "returns http success" do
      get :home
      assert_response :success
    end
    it "should have right title" do
    	get :home
    	assert_select "title","Book Browser | Home"
    end
    it "should have right content  Welcome to Book Browser" do
    	get :home
    	assert_select "h1" , "Welcome to Book Browser"
    end
    it "should have browse link" do
    	get :home
    	assert_select "a" , :text => "Browse"
    end
    it "should have about link" do
    	get :home
    	assert_select "a" , :text => "About"
    end

  end

  describe "About page" do
    it "returns http success" do
      get :about
      assert_response :success
    end
    it "should have right title" do
    	get :about
    	assert_select "title","Book Browser | About"
    end
    it "should have right content  About Book Browser" do
    	get :about
    	assert_select "h1" , "About Book Browser"
    end
    it "should have browse link" do
    	get :about
    	assert_select "a" , :text => "Browse"
    end
    it "should have home link" do
    	get :about
    	assert_select "a" , :text => "Home"
    end
    it "should have about link" do
    	get :home
    	assert_select "a" , :text => "About"
    end

  end

end
