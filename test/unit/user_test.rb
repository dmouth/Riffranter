require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end




# == Schema Information
#
# Table name: users
#
#  id                :integer         not null, primary key
#  first_name        :string(255)
#  last_name         :string(255)
#  email             :string(255)
#  password_hash     :string(255)
#  password_salt     :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#  admin             :boolean
#  image             :string(255)
#  handle            :string(255)
#  send_mail_updates :boolean
#

