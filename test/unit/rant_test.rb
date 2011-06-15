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
#  id         :integer(4)      not null, primary key
#  user_id    :integer(4)
#  persona_id :integer(4)
#  body       :text
#  ip         :string(255)
#  created_at :datetime
#  updated_at :datetime
#

