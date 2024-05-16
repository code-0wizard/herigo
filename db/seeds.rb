# usersデータ
10.times do |n|
  name  = "hoge-#{n+1}"
  email = "hoge-#{n+1}@railstutorial.org"
  password = "password123"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               admin:     true,
               activated: true,
               activated_at: Time.zone.now)
end

# countriesデータ
Country.create!(name: "オーストラリア")
Country.create!(name: "イタリア")
Country.create!(name: "アメリカ")
Country.create!(name: "日本")
Country.create!(name: "カナダ")

# heritagesデータ
Australia = Country.find_by(name: "オーストラリア")
3.times do
  name = Faker::Lorem.sentence(word_count: 10)
  content = Faker::Lorem.sentence(word_count: 20)
  Australia.heritages.create!(
    name: name, 
    content: content,
    image_path: "heritage/nature.png")
end

Italy = Country.find_by(name: "イタリア")
3.times do
  name = Faker::Lorem.sentence(word_count: 10)
  content = Faker::Lorem.sentence(word_count: 20)
  Italy.heritages.create!(
    name: name, 
    content: content, 
    image_path: "heritage/nature.png")
end

# reviewsデータ
heritage_ids = Heritage.pluck(:id)
users = User.take(10)
users.each do |user| 
  10.times do
    Review.create!(
      content: Faker::Lorem.paragraph(sentence_count: 2),
      heritage_id: heritage_ids.sample, 
      user_id: user.id,
    )
  end
end
