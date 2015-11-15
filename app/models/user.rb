class User < ActiveRecord::Base
  attr_accessible :email, :name , :password , :admin

  has_secure_password

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name ,  presence: true
  validates :email , presence: true , format: {with: VALID_EMAIL_REGEX} ,uniqueness: {case_sensitive: false	}
  validates :password , presence: true


  
   def User.new_token
       SecureRandom.urlsafe_base64
   end 
 
    def User.digest(token)
    	Digest::SHA1.hexdigest(token.to_s)
    end
end
