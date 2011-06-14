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
#  id         :integer         not null, primary key
#  rant_id    :integer
#  user_id    :integer
#  stars      :integer
#  created_at :datetime
#  updated_at :datetime
#

