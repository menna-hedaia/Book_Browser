class BooksController < ApplicationController
  def index
  	@books = Book.paginate(page: params[:page])
  end

  def show
  	begin
  		@book = Book.find(params[:id])	
  	rescue 
  		flash[:notice] = "Error no book with that id"
  		redirect_to books_path
  		return
  	end	
  end

  def edit
    begin
      @book = Book.find(params[:id])  
    rescue 
      flash[:notice] = "Error no book "
      render 'index'
      return
    end 
  end

  def update
    @book = Book.find(params[:id])
    if @book.update_attributes(:title => params[:book][:title] , :author  => params[:book][:author] , :publisher  => params[:book][:publisher])
      flash[:notice] = "Book Updated"
      redirect_to books_path
    else
       flash[:notice] = "Invalid edit"
       redirect_to edit_book_path(@book.id)
    end
  end
end
