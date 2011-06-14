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
#  id         :integer         not null, primary key
#  user_id    :integer
#  persona_id :integer
#  body       :text
#  ip         :string(255)
#  created_at :datetime
#  updated_at :datetime
#

