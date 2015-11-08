FactoryGirl.define do 
	factory :book do
        sequence (:author) {|n| "Author #{n}"}
        sequence (:title) {|n| "title #{n}"}
        sequence (:publisher) {|n| "publisher#{n}"}
		
	end
end