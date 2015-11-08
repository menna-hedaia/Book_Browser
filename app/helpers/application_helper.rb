
module ApplicationHelper
	#this helper is made if no title is specified, go to app layout and add full_title(yield :title) instead of the other long line
	def full_title (page_title = "")
		base_title = "Book Browser"
		if page_title.nil?
			base_title
	    else
	    	base_title + " | " + page_title
	    end
	end    	
end
