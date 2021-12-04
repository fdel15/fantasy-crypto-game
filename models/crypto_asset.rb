##
# A CryptoAsset represents a real world crypto currency
# Initial data is pulled from coinbase and we keep the coinbase_id
##
require 'byebug'
class CryptoAsset
  attr_reader :id, :coinbase_id, :symbol, :name, :slug, :coinbase_asset_type,
              :white_paper_url, :website, :description
  
  COINBASE_DATA_FILE = '/Users/frankdelpidio/workspace/crypto/fantasy_crypto/data/1638099702/1638099702_assets.json'

  def initialize(coinbase_id)
    @id = SecureRandom.uuid
    @coinbase_id = coinbase_id
    @symbol = coinbase_data[:symbol]
    @name = coinbase_data[:name]
    @slug = coinbase_data[:slug]
    @coinbase_asset_type = coinbase_data[:asset_type]
    @white_paper_url = coinbase_data[:white_paper]
    @website = coinbase_data[:website]
    @description = coinbase_data[:description]
  end

  private

  def coinbase_data
    @coinbase_data ||= coinbase_data_hash.transform_keys(&:to_sym)
  end

  def coinbase_data_hash
    JSON.parse(File.read(COINBASE_DATA_FILE))['data'].find do |coin|
      coin['id'] == coinbase_id
    end
  end
end