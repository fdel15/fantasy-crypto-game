##
# A ContestEntry is an object that links a lineup to a contest
# A ContestEntry is responsible for recording how many points the lineup scores
##

require 'securerandom'

class ContestEntry
  attr_reader :id, :contest_id, :lineup_id, :score

  def initialize(contest_id:, lineup_id:)
    @id = SecureRandom.uuid
    @contest_id = contest_id
    @lineup_id = lineup_id
    @score = 0
  end

  def update_score(score)
    @score = score
  end
end