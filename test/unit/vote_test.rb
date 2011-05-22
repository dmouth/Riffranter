require 'test_helper'

class VoteTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end

# == Schema Information
#
# Table name: votes
#
#  id         :integer(4)      not null, primary key
#  rant_id    :integer(4)
#  user_id    :integer(4)
#  stars      :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

