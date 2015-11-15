FactoryGirl.define do 
	factory :book do
        sequence (:author) {|n| "Author #{n}"}
        sequence (:title) {|n| "title #{n}"}
        sequence (:publisher) {|n| "publisher#{n}"}
	end
	factory :user do
		sequence (:name) {|n| "Name #{n}"}
        sequence (:email) {|n| "user_#{n}@example.com"}
        sequence (:password) {|n| "pass#{n}"}
        sequence (:admin) {true}
    end
end