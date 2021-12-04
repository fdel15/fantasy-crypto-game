require 'byebug'
require 'date'
require 'json'
require 'securerandom'

##
# TODO: ContestEntryValidator -> class responsbile for validating whether a lineup can be submitted to a contest
#
# TODO: ContestEntryScorer -> class responsbile for updating the points scored for a ContestEntry
#
# TODO: Remove data parsing from CryptoAsset class
#
# TODO: Write Unit Tests for models
##

# Lets start with hard coding some data
# An Initial Contest
# Populate CryptoAssets with COINS above
# CRUD a lineup

require_relative 'models/contest'
require_relative 'models/lineup'
require_relative 'models/crypto_asset'

coinbase_ids = [
  "5b71fc48-3dd3-540c-809b-f8c94d0e68b5", # BTC
  "d85dce9b-5b73-5c3c-8978-522ce1d1c1b4", # ETH
  "63062039-7afb-56ff-8e19-5e3215dc404a" # ADA
]

# Hard code cryptos
BTC = CryptoAsset.new('5b71fc48-3dd3-540c-809b-f8c94d0e68b5')
ETH = CryptoAsset.new('d85dce9b-5b73-5c3c-8978-522ce1d1c1b4')
ADA = CryptoAsset.new('63062039-7afb-56ff-8e19-5e3215dc404a')

# Hard code contests
future_contest = Contest.new(Date.today + 1, Date.today + 12, 'upcoming')
active_contest = Contest.new(Date.today - 1, Date.today + 12, 'running')
past_contest   = Contest.new(Date.today - 5, Date.today - 1, 'finished')

# Create a lineup
lineup = LineUp.new

# Create Contest Entry
lineup.enter_in_contest(future_contest)
contest_entry = future_contest.contest_entries.find { |entry| entry.lineup_id == lineup.id }

# Update Contest Entry
slots = lineup.slots.each_with_object({}) { |s, hash| hash[s.id] = [BTC, ADA, ETH].sample.id }
lineup.update(slots)


# Score a Contest Entry
puts "Entry score: #{contest_entry.score}"
contest_entry.update_score(rand(1..100))
sleep 1
puts "Entry score: #{contest_entry.score}"

# Delete Contest Entry
puts "Number of entries: #{future_contest.contest_entries.length}"
future_contest.contest_entries.delete_if { |entry| entry.id == contest_entry.id }
sleep 1
puts "Number of entries: #{future_contest.contest_entries.length}"

puts "FINISHED"
