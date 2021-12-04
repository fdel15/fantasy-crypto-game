##
# A lineup is an object that allows users to enter contests
# A lineup will belong to a user
# A lineup has a type that define the available slots
# A lineup can have many contest entries so that a user can submit the same lineup to multiple contests
##

require 'securerandom'
require_relative 'slot'

class LineUp
  attr_reader :id, :user_id, :type, :slots
  def initialize(user_id = nil, type = nil)
    @id = SecureRandom.uuid
    @user_id = user_id
    @type = type || 'BETA'
    @slots = generate_slots
  end

  def update(slot_selections = {})
    @slots = @slots.map do |slot|
      crypto_asset_id = slot_selections[slot.id] || slot.crypto_asset_id
      slot.update_crypto_asset_id(crypto_asset_id)
      slot
    end
  end

  def enter_in_contest(contest)
    if contest.valid_lineup?(self)
      contest.create_contest_entry(id)
    else
      raise 'Invalid lineup'
    end
  end

  private

  def generate_slots
    generate_beta_slots
  end

  def generate_beta_slots
    ['First', 'Second', 'Third'].map do |name|
      Slot.new(name)
    end
  end
end