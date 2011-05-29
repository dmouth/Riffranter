class Rant < ActiveRecord::Base
  belongs_to :user
  belongs_to :persona
  has_many :votes

  validates :user_id, :presence => true
  validates :persona_id, :presence => true
  validates :body, :presence => true
  validates :ip, :presence => true
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

