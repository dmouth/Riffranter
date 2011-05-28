class Vote < ActiveRecord::Base
  belongs_to :rant
  belongs_to :user

  STAR_TITLES = %w[Lame Alright Good Great LOL]

  validates :rant_id, :presence => true
  validates :user_id, :presence => true
  validates :stars, :presence => true, :inclusion => { :in => 1..5 }


  def star_title
    STAR_TITLES[star - 1]
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

