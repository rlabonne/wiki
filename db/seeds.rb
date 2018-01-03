require 'faker'

# Create Standard User
user = User.new(
  :username => Faker::Name.unique.first_name,
  :email => Faker::Internet.unique.email,
  :password => 'password',
  :password_confirmation => 'password',
  :role => 'standard',
)
user.skip_confirmation!
user.save!
users = User.all

# Create Admin User
user = User.new(
  :username => Faker::Name.unique.first_name,
  :email => Faker::Internet.unique.email,
  :password => 'password',
  :password_confirmation => 'password',
  :role => 'admin',
)
user.skip_confirmation!
user.save!
users = User.all

# Create Premium User
user = User.new(
  :username => Faker::Name.unique.first_name,
  :email => Faker::Internet.unique.email,
  :password => 'password',
  :password_confirmation => 'password',
  :role => 'premium',
)
user.skip_confirmation!
user.save!
users = User.all

# Create Wikis
50.times do
  Wikii.create!(
    user: users.sample,
    title:  Faker::Dog.breed,
    body:   Faker::Dog.meme_phrase,
    private: false
  )
end
wikkis = Wikii.all

puts "Seed finished"
#puts "#{User.count} users created"
#puts "#{Wikki.count} wikis created"
