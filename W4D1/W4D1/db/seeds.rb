require 'faker'

10.times do |i|
  User.create(username: Faker::Superhero.name)
  Artwork.create(title: Faker::Superhero.power, image_url: Faker::Internet.url, artist_id: i + 1 )
end

ArtworkShare.create(artwork_id: rand(1..10), viewer_id: rand(1..10))
ArtworkShare.create(artwork_id: rand(1..10), viewer_id: rand(1..10))
ArtworkShare.create(artwork_id: rand(1..10), viewer_id: rand(1..10))
ArtworkShare.create(artwork_id: rand(1..10), viewer_id: rand(1..10))
