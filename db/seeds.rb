# 50.times do
#   Comment.create  body: Faker::Hipster.sentence
# end
# 50.times do
#   Post.create title: Faker::Lorem.word,
#               body: Faker::Lorem.sentence
# end
["Food", "Cars", "Fashion", "Arts"].each do |cat|
  Category.create title: cat
end
