require 'random_data'

# Create User
user = User.new(
  :username => 'testUser',
  :email => 'testUser@test.com',
  :password => 'password',
  :password_confirmation => 'password'
)
user.skip_confirmation!
user.save!
users = User.all

# Create Wikis
50.times do
  Wikii.create!(
    user: users.sample,
    title:  RandomData.random_word,
    body:   RandomData.random_paragraph,
    private: false
  )
end
wikkis = Wikii.all

puts "Seed finished"
#puts "#{User.count} users created"
#puts "#{Wikki.count} wikis created"
