class BooksController < ApplicationController
  def index
  	@books = Book.paginate(page: params[:page])
  end

  def show	
  	@book = Book.find(params[:id])
  end
end