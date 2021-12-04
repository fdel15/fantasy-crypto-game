require 'byebug'
require 'json'
data_file = 'data/1638099702/1638099702_assets.json'

COINS = ['ADA', 'ALGO', 'BTC', 'ETH', 'SOL']

crypto = JSON.parse(File.read(data_file))['data']
coins = crypto.select { |c| COINS.include?(c['symbol'])}
currencies = crypto.select { |c| c['asset_type'] == 'currency' }
platforms  = crypto.select { |c| c['asset_type'] == 'platform' }
tokens     = crypto.select { |c| c['asset_type'] == 'token' }

def write_asset_type_to_file(coins, asset_type)
  coins.each do |coin|
    File.open("data/1638099702/#{asset_type}/#{coin['slug']}.json", 'w') do |f|
      f.puts coin
    end
  end
end

write_asset_type_to_file(currencies, "currencies")
write_asset_type_to_file(platforms, "platforms")
write_asset_type_to_file(tokens, "tokens")