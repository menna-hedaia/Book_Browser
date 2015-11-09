class BooksController < ApplicationController
  def index
  	@books = Book.paginate(page: params[:page])
  end

  def show
  	begin
  		@book = Book.find(params[:id])	
  	rescue 
  		flash[:notice] = "Error no book with that id"
  		redirect_to :controller => 'static_pages', :action => 'home' 
  		
  		return
  	end	

  	
  end
end
