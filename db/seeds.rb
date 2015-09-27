# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Podcast.create(name: "The Bike Shed",
               feed_url: "http://simplecast.fm/podcasts/282/rss",
               image: "http://simplecast-media.s3.amazonaws.com/podcast/image/282/1433513863-artwork.jpg",
               link: "http://bikeshed.fm")

Podcast.create(name: "Ruby Rogues",
               feed_url: "http://feeds.feedwrench.com/RubyRogues.rss",
               image: "https://s3.amazonaws.com/devchat.tv/ruby-rogues-thumb.jpg",
               link: "http://rubyrogues.com")

Podcast.create(name: "Giant Robots Smashing into other Giant Robots Podcast",
               feed_url: "http://simplecast.fm/podcasts/271/rss",
               image: "http://simplecast-media.s3.amazonaws.com/podcast/image/271/1437963534-artwork.jpg",
               link: "http://giantrobots.fm/")
