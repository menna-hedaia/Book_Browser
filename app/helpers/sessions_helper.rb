module SessionsHelper
    
	def sign_in(user)
       remember_token = User.new_token
       cookies.permanent[:remember_token] = remember_token
       user.update_attribute(:remember_token , User.digest(remember_token))
       self.current_user = user
	end	

    #sets current user to user who just signed in this is a setter
	def current_user=(user)
		@current_user = user
    end

    #when called for the first time sets the current user to the output of the find method otherwise te current usr has ben set before this is a getter
    def current_user
        token  = User.digest(cookies[:remember_token])
        @current_user = @current_user || User.find_by_remember_token(token)		
    end

    def signed_in?
      !current_user.nil?
    end

    def sign_out
      current_user.update_attribute(:remember_token , User.digest(User.new_token))
      cookies.delete(:remember_token)
      self.current_user = nil  #optional but a must if we dont redirect
    end
end
