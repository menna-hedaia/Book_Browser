require 'spec_helper'

describe BooksController do
render_views

  describe "Books index page" do
    before(:each) do
      FactoryGirl.create (:book)
      FactoryGirl.create (:book)
      get :index
    end

    it "returns http success" do
      assert_response :success
    end
    it "should have the right title" do
      assert_select "title","Book Browser | All Books"
    end
    it "should have right content" do
        assert_select "h1", "All Books"
    end
    it "should list each book" do
      Book.all.each do |book|
        assert_select "p" , book.title + "  Written by : " + book.author + " , Published by : " + book.publisher
      end
    end 
    it "should have detail link for each book" do
        assert_select "a" ,  :text => "Details"
        get :show  , id: Book.first.id
        assert_response :success
    end 
  end

  describe "pagination" do

    before(:all) {30.times {FactoryGirl.create(:book)}}
    after(:all) {Book.delete_all}
    before(:each) {get :index}
    it "should list each book" do
      Book.paginate(page: 1).each do |book|
        assert_select "p" , book.title + "  Written by : " + book.author + " , Published by : " + book.publisher
      end 
    end
  end  


describe "Book show page" do
  before(:each) do
      FactoryGirl.create(:book)
      FactoryGirl.create(:book)
      get :show , id: Book.first.id
  end
    it "returns http success" do
      assert_response :success
    end
    it "should have the right title" do
      assert_select "title" , "Book Browser | #{Book.first.title}"
    end
    it "should have the right content" do
      assert_select "p" , Book.first.title + "  Written by : " + Book.first.author + " , Published by : " + Book.first.publisher
    end
      
  end

  
end
