
namespace :db  do 
	desc "Fill database with sample data"
	task populate: :environment do
	 Book.create!(author:  "Example Author",
	 	          title:    "Example title",
	 	          publisher: "Example publisher")
	10.times do 
		Book.create!(author:    Faker::Name.name,
			         title:     Faker::Name.name,
			         publisher: Faker::Company.name)
	end

	admin = User.create!(name: "Admin1",
						 email: "admin@example.com",
						 password: "foobar",
						 admin: true)
	
end
end