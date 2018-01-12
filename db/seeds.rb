require 'faker'

# Create Standard User
user = User.new(
  :username => 'standard',
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
  :username => 'admin',
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
  :username => 'premium',
  :email => Faker::Internet.unique.email,
  :password => 'password',
  :password_confirmation => 'password',
  :role => 'premium',
)
user.skip_confirmation!
user.save!
users = User.all
third = User.third

# Create Wikis
15.times do
  Wikii.create!(
    user: users.sample,
    title:  Faker::Dog.breed,
    body:   Faker::Dog.meme_phrase,
    private: false
  )
end
wikkis = Wikii.all

15.times do
  Wikii.create!(
    user: third,
    title:  Faker::Dog.breed,
    body:   Faker::Dog.meme_phrase,
    private: true
  )
end
wikkis = Wikii.all

puts "Seed finished"
#puts "#{User.count} users created"
#puts "#{Wikki.count} wikis created"
