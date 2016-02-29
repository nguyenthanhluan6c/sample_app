def rand_time(from, to=Time.now)
  Time.at(rand(from.to_f..to.to_f))
end

User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin:     true,
             activated: true,
             activated_at: Time.zone.now)

User.create!(name:  "Kratos",
             email: "nguyenthanhluan@gmail.com",
             password:              "111111",
             password_confirmation: "111111",
             admin:     true,
             activated: true,
             activated_at: Time.zone.now)



99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
              email: email,
              password:              password,
              password_confirmation: password,
              activated: true,
              activated_at: Time.zone.now)
end


users = User.order(:created_at).take(6)
50.times do
  title = Faker::Lorem.sentence(rand(5..15))
  body  = Faker::Lorem.paragraphs(rand(5..15) )
  users.each { |user| user.entries.create!(title: title,body: body) }
end

entries = Entry.order(:created_at).take(50)

entries.each { |entry| 
  rand_times = rand(30);
  rand_times.times do
  offset    = rand(User.count)
  rand_user = User.offset(offset).first
  content = Faker::Lorem.sentence(rand(5..15))
  entry.comments.create!(user: rand_user, content: content, created_at: rand_time(15.days.ago) ) 
  end
}

# Following relationships
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
