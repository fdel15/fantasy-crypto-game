# Get crypto currency data
# I want to be able to view all crypto currencies available through CoinBase
# I want the coinbase description and links to white papers and documentation
# I want to store this data in a local file for now
# I want to parse the data to assign a "position" to each coin

require 'byebug'
require 'csv'
require 'json'
require 'net/http'
require 'openssl'
require 'uri'

# I did not find this URI documented in any of the CoinBase APIs
# I found it by inspecting the networks tab when clicking on "Trade" when signed into
# my coinbase account.
# This makes me believe the endpoint is unstable and could stop working one day
url = URI('https://www.coinbase.com/api/v2/assets/info?filter=holdable&locale=en&')

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true

request = Net::HTTP::Get.new(url)
request['Accept'] = 'application/json'

puts 'MAKING REQUEST...'
response =  http.request(request)
puts 'RESPONSE RECEIVED!'

# Write data to file
timestamp = Time.now.to_i.to_s

# File.open("data/#{timestamp}_assets.json", 'w') do |f|
#   f.puts response.body
# end

# Format data into JSON to make it easier to parse into a CSV
json_data = JSON.parse(File.read("data/#{timestamp}_assets.json"))

# Array of hash objects
# Each hash is the data for a crypto currency
# hash keys = id, symbol, name, slug, uri_scheme, color, asset_type, image_url,
#             listed, description, asset_type_description, website, white_paper,
#             exponent, unit_price_scale, transaction_unit_price_scale, conges,
#             links, destination_tag, tradable_on_wallet, related_assets, supported
currency_hash_array = json_data['data']

CSV.open("data/#{timestamp}_assets.csv", 'w') do |csv|
  headers = currency_hash_array.first.keys
  csv << headers
  currency_hash_array.each do |hash|
    row = headers.map { |header| hash[header].to_s }
    csv << row
  end
end

puts "Finished"