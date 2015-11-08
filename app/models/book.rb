class Book < ActiveRecord::Base
  attr_accessible :author, :publisher, :title
end
