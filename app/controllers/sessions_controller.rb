class SessionsController < ApplicationController
  def new
  end

  def create
  	begin
  		user = User.find_by_email(params[:session][:email])
  	rescue
     flash[:notice] = "Invalid Email/Password combination"
     render 'new'
  		return 
  	end
  	
  	if user && user.authenticate(params[:session][:password]) 
  		if user.admin?
  		  sign_in user
        flash[:notice] = "success"
        redirect_to books_path
  		else
         flash[:notice] = "Administrator Only"
         render 'new'
  		end  
  	else
  		flash[:notice]= "Invalid Email/Password combination"
  		render 'new'
  	end
  end

  def destroy
  	sign_out
    render 'static_pages/home'
  end
end
