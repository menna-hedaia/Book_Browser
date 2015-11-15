class Book < ActiveRecord::Base
  attr_accessible :author, :publisher, :title
  validates :title , :presence => true
end
