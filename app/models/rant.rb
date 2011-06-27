class Rant < ActiveRecord::Base
  belongs_to :user
  belongs_to :persona
  has_many :votes

  validates :user_id, :presence => true
  validates :persona_id, :presence => true
  validates :body, :presence => true
  validates :ip, :presence => true
  
  def self.hot(limit = 25)
    find_by_sql("SELECT rants.id, rants.user_id, rants.persona_id, rants.body, rants.ip, rants.created_at, rants.updated_at, avg(votes.stars) as rating FROM rants INNER JOIN votes ON votes.rant_id = rants.id group by rants.id, rants.user_id, rants.persona_id, rants.body, rants.ip, rants.created_at, rants.updated_at order by rating desc limit #{limit}")
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

