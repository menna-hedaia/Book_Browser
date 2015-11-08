namespace :db  do 
	desc "Fill database with sample data"
	task populate: :environment do
	 Book.create!(author:  "Example Author",
	 	          title:    "Example title",
	 	          publisher: "Example publisher")
	89.times do 
		title = Faker::Name.name
		author = Faker::Name.name
		publisher = Faker::Company.name
		Book.create!(author: author,
			         title:  title,
			         publisher: publisher)
	end
end
end