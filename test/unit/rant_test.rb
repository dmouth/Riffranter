require 'test_helper'

class RantTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end


# == Schema Information
#
# Table name: rants
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  persona_id :integer
#  body       :text
#  ip         :string(255)
#  created_at :datetime
#  updated_at :datetime
#

