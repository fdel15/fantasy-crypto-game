##
# A Slot is an object that links a crypto asset to a lineup
##
class Slot
  attr_reader :id, :name, :crypto_asset_id

  def initialize(name, crypto_asset_id = nil)
    @id = SecureRandom.uuid
    @name = name
    @crypto_asset_id = crypto_asset_id
  end

  def update_crypto_asset_id(crypto_asset_id)
    @crypto_asset_id = crypto_asset_id
  end
end