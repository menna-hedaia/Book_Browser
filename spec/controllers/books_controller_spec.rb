require 'spec_helper'

describe BooksController do
render_views
before(:all) {30.times {FactoryGirl.create(:book)}}
after(:all) {Book.delete_all}

  describe "#index" do
    let(:user) {FactoryGirl.create(:user)}
    before(:each) do
      get :index
    end
    subject{page}
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
        assert_select "div" , book.title + "  Written by : " + book.author + " , Published by : " + book.publisher
      end
    end 
    it "should have detail link for each book" do
        assert_select "a" ,  :text => "Details"
        get :show  , id: Book.first.id
        assert_response :success
    end
    it "should not have edit links" do
      expect(page).to_not have_link("Edit")
     end 

     
  end

  describe "pagination" do 
    it "should list each book" do
      get :index
      Book.paginate(page: 1).each do |book|
        assert_select "div" , book.title + "  Written by : " + book.author + " , Published by : " + book.publisher
      end 
    end
  end  


describe "#show" do
  describe "valid show" do
        before(:each) do
            get :show , id: Book.first.id
        end
          it "returns http success" do
            assert_response :success
          end
          it "should have the right title" do
            assert_select "title" , "Book Browser | #{Book.first.title}"
          end
          it "should have the right content" do
            assert_select "div" , Book.first.title + "  Written by : " + Book.first.author + " , Published by : " + Book.first.publisher
          end
  end

  describe "invalid show" do
   
    it "should not show details" do
       get :show , id: ""
       expect(response).to redirect_to(books_path)
       expect(flash[:notice]).to be_present
    end
 end
end

describe "#edit" do
  let(:user) {FactoryGirl.create(:user)}
  before(:each) do
       sign_in user
       expect(user).to be_admin
    end
    it "should have edit link for admins" do
      get :index
      assert_select "a" , :text => "Edit"
    end 
end

describe "#update" do
let(:user) {FactoryGirl.create(:user)}
let(:new_title) {"New_title"}
let(:new_author) {"New_author"}
let(:new_publisher){"New_publisher"}
before do
      sign_in user
      expect(user).to be_admin      
 end 

        it "should update valid attr" do
          put :update , id: Book.first.id ,  book: FactoryGirl.attributes_for(:book, :title => new_title , :author => new_author , :publisher => new_publisher)
          expect(Book.first.reload.title).to eq(new_title)
          expect(Book.first.reload.author).to eq(new_author)
          expect(Book.first.reload.publisher).to eq(new_publisher)
          expect(response).to redirect_to(books_path)
          expect(flash[:notice]).to be_present
        end

        it "should reject invalid attr" do
          Book.first.update_attribute(:title, "" )
          put :update , id: Book.first.id ,  book: FactoryGirl.attributes_for(:book, :title => "" , :author => new_author , :publisher => new_publisher)
          expect(response).to redirect_to(edit_book_path(Book.first.id))
          expect(flash[:notice]).to be_present
        end
end
end