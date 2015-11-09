
module ApplicationHelper
	#this helper is made if no title is specified, go to app layout and add full_title(yield :title) instead of the other long line
	def full_title (page_title = "")
		if page_title.nil?
		     "Book Browser"
	    else
	    	"Book Browser" + " | " + page_title
	    end
	end    	
end
