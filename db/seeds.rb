# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Categories
Category.create(name: 'Entertainment')
Category.create(name: 'Fitness and Health')
Category.create(name: 'Shopping')
Category.create(name: 'Food and Dining')

# Popular Subscriptions
PopularSubscription.create(
  name: 'Netflix',
  logo: 'netflix-logo.png',
  link: 'https://www.netflix.com/'
)
PopularSubscription.create(
  name: 'Amazon Prime',
  logo: 'amazonprime-logo.jpeg',
  link: 'https://www.amazon.ca/amazonprime'
)
PopularSubscription.create(
  name: 'Disney Plus',
  logo: 'disneyplus-logo.jpeg',
  link: 'https://www.disneyplus.com/'
)
PopularSubscription.create(
  name: 'Doordash',
  logo: 'doordash-logo.png',
  link: 'https://www.doordash.com/'
)
PopularSubscription.create(
  name: 'MasterClass',
  logo: 'masterclass-logo.png',
  link: 'https://www.masterclass.com/'
)
PopularSubscription.create(
  name: 'Spotify',
  logo: 'spotify-logo.png',
  link: 'https://www.spotify.com/premium/'
)
PopularSubscription.create(
  name: 'Uber Eats',
  logo: 'ubereats-logo.png',
  link: 'https://www.ubereats.com/'
)