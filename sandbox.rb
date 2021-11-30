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

byebug
puts 'finished'

The world’s first cryptocurrency, Bitcoin is stored and exchanged securely on the internet through a digital ledger known as a blockchain. Bitcoins are divisible into smaller units known as satoshis — each satoshi is worth 0.00000001 bitcoin.

Ethereum is a decentralized computing platform that uses ETH (also called Ether) to pay transaction fees (or “gas”). Developers can use Ethereum to run decentralized applications (dApps) and issue new crypto assets, known as Ethereum tokens.

Solana is a decentralized computing platform that uses SOL to pay for transactions. Solana aims to improve blockchain scalability by using a combination of proof of stake consensus and so-called proof of history. As a result, Solana claims to be able to support 50,000 transactions per second without sacrificing decentralization.

Cardano (ADA) is a blockchain platform built on a proof-of-stake consensus protocol (called Ouroboros) that validates transactions without high energy costs. Development on Cardano uses the Haskell programming language, which is described as enabling Cardano “to pursue evidence-based development for unparalleled security and stability.” The blockchain’s native token, ADA, is named after the 19th century mathematician, Ada Lovelace.

Algorand is a cryptocurrency and blockchain protocol that aims to be simultaneously scalable, secure, and decentralized. It uses a consensus algorithm called pure proof-of-stake.

# Contest
# Contest has many ContestEntries
# Contest has a status -> Active, Future, Completed
# Contest has a start date
# Contest has an end date

# ContestEntry
# belongs to a lineup
# belongs to a contest
# has a score

# Line Up
# Line up belongs to a user
# Line up has many slots
# Line up as a type => beta for now => type will dictate how to validate it
# Line up can have many ContestEntries

# Slot
# Slot belongs to a line up
# Slot belongs to a Crypto Asset

# CryptoAsset
# has a coinbase_id
# has many slots
# includes relevant fields from coinbase data: symbol, name, slug, coinbase_asset_type, white_paper, website,listed_on_coinbase 