##
# A contest is an object that keeps track of a competition.
# A contest will know the date it begins and the date it ends
# A contest will have many contest entries that are competing
# A contest will have rules associated for a valid line up
# A contest will have rules associated for scoring points during the competition
##
require 'date'
require 'securerandom'

require_relative 'contest_entry'

class Contest
  attr_reader :start_date, :end_date, :name, :status, :id, :contest_entries

  def initialize(start_date, end_date, name)
    @id = SecureRandom.uuid
    @start_date = start_date
    @end_date = end_date
    @name = name
    @status = calculate_status
    @contest_entries = []
  end

  def calculate_status
    today = Date.today
    if today < start_date
      "FUTURE"
    elsif today > end_date
      "COMPLETED"
    else
      "ACTIVE"
    end
  end

  def valid_lineup?(lineup)
    true
  end

  def create_contest_entry(lineup_id)
    entry = ContestEntry.new(contest_id: id, lineup_id: lineup_id)
    contest_entries << entry
  end

  def delete_contest_entry(contest_entry_id)
    contest_entries.reject! { |entry| entry.id == contest_entry_id }
  end
end